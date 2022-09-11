# Terraform


### Create SSH Key

```bash
$ ssh-keygen -t ed25519 -C "kind-mesh@digitalocean.com" -q -N '' -f ssh-key
```

### Inicializar terraform
```
$ docker run -it --rm -v $(pwd):/kind-mesh -w /kind-mesh --entrypoint sh hashicorp/terraform

/kind-mesh/terraform # cd terraform
/kind-mesh/terraform # ssh-add ssh-key
```
