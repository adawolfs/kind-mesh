# Create droplet with name "server"

data "template_file" "user_data" {
  template = file("./user_data.yaml")
}

resource "digitalocean_droplet" "server" {
  name = "server"
  size = "s-4vcpu-8gb"
  # size = "s-1vcpu-1gb"
  image = "centos-stream-8-x64"
  region = "nyc3"
  ssh_keys  = ["${digitalocean_ssh_key.kind-mesh.fingerprint}"]
  user_data = data.template_file.user_data.rendered

  provisioner "file" {
    source      = "../kind/cluster.yaml"
    destination = "/root/kind-cluster.yaml"
  }
  provisioner "file" {
    source      = "../metallb/configmap.yaml"
    destination = "/root/metallb-configmap.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin firewalld",
      "systemctl --now enable firewalld",
      "systemctl --now enable docker",
      "curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64",
      "chmod +x ./kind",
      "sudo mv ./kind /usr/local/sbin/kind",
      "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
      "install -o root -g root -m 0755 kubectl /usr/local/sbin/kubectl",
      "kind create cluster --config /root/kind-cluster.yaml",
      "kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml",
      "kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml",
      "kubectl apply -f /root/metallb-configmap.yaml",
    ]
  }

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file("./ssh-key")
  }

}
