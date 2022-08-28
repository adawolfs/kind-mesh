# Terraform 

## Overview

Terraform is a tool for building, configuring, and deploying infrastructure. 

This configuration creates a DigitalOcean droplet with a Kubernetes cluster and a MetalLB mesh.

## Installation
Create a new access token for the DigitalOcean API: https://docs.digitalocean.com/reference/api/create-personal-access-token/

```
$ docker run -it --rm -v $(pwd):/mesh-kind  -w /mesh-kind --entrypoint sh hashicorp/terraform
/mesh-kind/terraform # cd terraform
/mesh-kind/terraform # export TF_VAR_digitalocean_token="dop_v1_...."
/mesh-kind/terraform # terraform apply
```

## Destroy
```
/mesh-kind/terraform # terraform destroy
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
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/sizes"

```