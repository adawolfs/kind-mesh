variable "project_id" {
}

variable "region" {
  default = "us-east1"
}

variable "ssh_key_path" {
  default = "../ssh-key"
}

variable "ssh_pub_key_path" {
  default = "../ssh-key.pub"
}

variable "ssh_user" {
  default = "kind-mesh-admin"
}

variable "ssh_posix_user" {
  default = "sa_000"
}

variable "zone" {
  default = "us-east1-b"
}

variable "instance_type" {
  default = "n1-standard-1"
}

variable "instance_name" {
  default = "server"
}
provider "google" {
  credentials = "${file("credentials.json")}"
  project     = var.project_id
  region      = var.region
}