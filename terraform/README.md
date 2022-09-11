# Terraform


### Create SSH Key

```bash
$ ssh-keygen -t ed25519 -C "kind-mesh@digitalocean.com" -q -N '' -f ssh-key
```

### Inicializar terraform
```
$ docker run -it --rm -v $(pwd):/mesh-kind  -w /mesh-kind --entrypoint sh hashicorp/terraform
/mesh-kind/terraform # cd terraform
/mesh-kind/terraform # ssh-add ssh-key
```
