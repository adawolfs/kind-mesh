# [Envoy Proxy](https://envoyproxy.io)

Envoy is an open source edge and service proxy that supports HTTP/2 and GRPC.

## Examples

### [basic-proxy](./basic-proxy.yaml)
This is a basic deployment created with NGINX and Envoy, NGINX serves an index.html file and Envoy proxies the requests to the service.

```
k apply -f basic-proxy.yaml
```