# [Envoy Proxy](https://envoyproxy.io)

Envoy is an open source edge and service proxy that supports HTTP/2 and GRPC.

## Examples

### [basic-proxy](./basic-proxy.yaml)
This is a basic deployment created with NGINX and Envoy, NGINX serves an index.html file and Envoy proxies the requests to the service.

```
k apply -f go-envoy.yaml
```


Create a configmap from static files

```
k create configmap envoy-basic-proxy-config --from-file=envoy.yaml=basic-proxy.yaml
```

```
k create configmap go-envoy-code --from-file=../servers/go/main.go
k create configmap python-envoy-code --from-file=../servers/python/main.py
k create configmap js-envoy-code --from-file=../servers/js/main.js
```

```
