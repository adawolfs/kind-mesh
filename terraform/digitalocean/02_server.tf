# Create droplet with name "server"

data "template_file" "user_data" {
  template = file("../scripts/user_data.yaml")
}

resource "digitalocean_droplet" "server" {
  name = "server"
  size = "s-4vcpu-8gb"
  # size = "s-1vcpu-1gb"
  image = "centos-stream-8-x64"
  region = "nyc3"
  ssh_keys  = ["${digitalocean_ssh_key.kind-mesh.fingerprint}"]
  user_data = data.template_file.user_data.rendered

  provisioner "remote-exec" {
    script = "../scripts/kind-mesh.sh"
  }

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    # private_key = file("../ssh-key")
  }

}

output "instance_ip_addr" {
  value = digitalocean_droplet.server.ipv4_address
}