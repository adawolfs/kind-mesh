# Digital Ocean  

## Overview

Terraform is a tool for building, configuring, and deploying infrastructure. 

This configuration creates a DigitalOcean droplet with a Kubernetes cluster and a MetalLB mesh.

## Installation
### DigitalOcean Access token
Create a new access token for the DigitalOcean API: https://docs.digitalocean.com/reference/api/create-personal-access-token/


### Create SSH Key

```bash
$ ssh-keygen -t ed25519 -C "kind-mesh@digitalocean.com" -q -N '' -f ssh-key
```

### Inicializar terraform
```
/kind-mesh/terraform # cd digitalocean
/kind-mesh/terraform/digitalocean # export TF_VAR_digitalocean_token="dop_v1_...."
/kind-mesh/terraform/digitalocean # terraform apply
```

## Steps
* Create ssh key
* Create a droplet
* Install docker
* Install firewalld
* Install kind
* Install kubectl
* Create a kubernetes cluster
* Install metallb
* Create a metallb configmap


## Resources
### DigitalOcean sizes

Check sizes.json for more info.

```
curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TF_VAR_digitalocean_token" \
  "https://api.digitalocean.com/v2/sizes" | jq . | less
```


# Don't forget to destroy when you finish

## Destroy
```
/kind-mesh/terraform/digitalocean # terraform destroy
```
