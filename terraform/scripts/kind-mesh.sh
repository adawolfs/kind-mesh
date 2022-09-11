#!/bin/bash

## Configure docker repository and install packages
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin firewalld git

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
kind create cluster --config /root/kind-mesh/kind/cluster.yaml

## Implement MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
kubectl apply -f /root/kind-mesh/metallb/configmap.yaml

export KIND_CONTROL_PLANE_PORT=$(docker inspect mesh-kind-external-load-balancer -f '{{index (index (index .NetworkSettings.Ports "6443/tcp") 0 ) "HostPort"}}')

