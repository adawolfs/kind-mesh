#!/bin/bash

## Configure docker repository and install packages
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin firewalld git jq

## Start services
systemctl --now enable firewalld
systemctl --now enable docker

## Install kind and kubectl
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
curl -Lo ./kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 ./kind /usr/local/sbin/kind
install -o root -g root -m 0755 ./kubectl /usr/local/sbin/kubectl

## Clone project and create cluster
git clone https://github.com/adawolfs/kind-mesh.git /root/kind-mesh
export PUBLIC_IP=$(curl ifconfig.me)
sed -i "s/0.0.0.0/$PUBLIC_IP/g" /root/kind-mesh/kind/cluster.yaml
kind create cluster --config /root/kind-mesh/kind/cluster.yaml

## Implement MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
kubectl apply -f /root/kind-mesh/metallb/configmap.yaml

kubectl create configmap envoy-basic-proxy-config --from-file=envoy.yaml=/root/kind-mesh/envoy/basic-proxy.yaml

kubectl apply -f /root/kind-mesh/envoy/go-envoy.yaml
kubectl create configmap go-envoy-code --from-file=/root/kind-mesh/servers/go/main.go

kubectl apply -f /root/kind-mesh/envoy/js-envoy.yaml
kubectl create configmap js-envoy-code --from-file=/root/kind-mesh/servers/js/main.js

kubectl apply -f /root/kind-mesh/envoy/py-envoy.yaml
kubectl create configmap py-envoy-code --from-file=/root/kind-mesh/servers/go/main.py

## Create variables
export KIND_INTERFACE=$(ip -o -4 route show to 172.18.0.0/16 | awk '{print $3}')

## Expose Go on 8081
export GO_LB_IP=$(kubectl get service go-envoy -o json | jq -r '.status.loadBalancer.ingress[] | .ip')
firewall-cmd --zone=public --add-port=8081/tcp --permanent   
firewall-cmd --zone=public --add-forward-port=port=8081:proto=tcp:toport=8081:toaddr=$GO_LB_IP --permanent

## Expose JS on 8082
export JS_LB_IP=$(kubectl get service js-envoy -o json | jq -r '.status.loadBalancer.ingress[] | .ip')
firewall-cmd --zone=public --add-port=8082/tcp --permanent   
firewall-cmd --zone=public --add-forward-port=port=8082:proto=tcp:toport=8082:toaddr=$JS_LB_IP --permanent

## Expose Py on 8083
export PY_LB_IP=$(kubectl get service py-envoy -o json | jq -r '.status.loadBalancer.ingress[] | .ip')
firewall-cmd --zone=public --add-port=8083/tcp --permanent   
firewall-cmd --zone=public --add-forward-port=port=8083:proto=tcp:toport=8083:toaddr=$PY_LB_IP --permanent

## Enable traffic on both directions
firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i eth0 -o $KIND_INTERFACE -j ACCEPT
firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i $KIND_INTERFACE -o eth0 -j ACCEPT
firewall-cmd --reload

