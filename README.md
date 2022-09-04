# KinD Mesh
[Slides](https://adawolfs.github.io/kind-mesh/#/0/0/0)

This is a test scenario created to evaluate mesh configurations with kubernetes. It is based on the following resources:

## [Terraform](./terraform/README.md)

Terraform is a tool for building, configuring, and deploying cloud infrastructure. This scenario uses it to create a DigitalOcean droplet with 8GB of RAM, 4 vCPU and a disk size of 160GB for about $0.08/hr.

The following packages are installed and configured:
* firewalld
* docker
* kind
* kubectl

## [KinD Cluster](./kind/README.md)
KinD lets you create a Kubernetes cluster with just a few commands. 

This project creates a cluster with the following shape:

* haproxy: 1 node
* k8s control-plane: 3 nodes
* k8s worker: 3 nodes

## [Metallb](./metallb/README.md)

MetalLB is a Kubernetes load balancer solution for bare metal-servers clusters.

This project enables `172.18.0.200-172.18.0.250` to be used as a load balancer for the k8s control-plane.

## [Envoy](./envoy/README.md)

Envoy is a edge and service proxy that supports HTTP/2 and GRPC, designed for Cloud Native Applications.


## Resources

* [DigitalOcean](https://www.digitalocean.com/)
* [Terraform](https://www.terraform.io/)
* [Kubernetes official documentation](https://kubernetes.io/docs/concepts/cluster-administration/addons/)
* [Kind documentation](https://kind.sigs.k8s.io/docs/user/quickstart/)
* [Docker documentation](https://docs.docker.com/engine/installation/linux/docker-ce/)
* [Metallb documentation](https://metallb.github.io/metallb/)

