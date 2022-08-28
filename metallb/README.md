# Metallb

https://kind.sigs.k8s.io/docs/user/loadbalancer/

## Installation

```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
kubectl apply -f configmap.yaml
```