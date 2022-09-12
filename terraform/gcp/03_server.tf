variable "ssh_key_path" {
}

variable "ssh_pub_key_path" {
}

// Create compute instance
resource "google_compute_instance" "server" {
  name         = "server"
  machine_type = "n1-standard-4"
  zone         = "us-east1-b"
  
  metadata = {
    ssh-keys = "adawolfs:${file(var.ssh_pub_key_path)}"
  }

  tags = ["kind-mesh"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-8-v20220822"
    }
  }

  provisioner "remote-exec" {
    script = "../scripts/kind-mesh.sh"
  }
  
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "adawolfs"
    private_key = file(var.ssh_key_path)
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "null_resource" "copy" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ~/.kube
      rm ~/.kube/config-kind-mesh
      scp -i ../ssh-key -o StrictHostKeyChecking=no root@${google_compute_instance.server.network_interface.0.access_config.0.nat_ip}:/root/.kube/config ~/.kube/config-kind-mesh
    EOT
  }
}

output "instance_ip_addr" {
  value = google_compute_instance.server.network_interface[0].access_config[0].nat_ip
}

output "go_addr" {
  value = "http://${google_compute_instance.server.network_interface[0].access_config[0].nat_ip}:8081"
  description = "Go application address"
}

output "js_addr" {
  value = "http://${google_compute_instance.server.network_interface[0].access_config[0].nat_ip}:8082"
  description = "JS application address"
}

output "python_addr" {
  value = "http://${google_compute_instance.server.network_interface[0].access_config[0].nat_ip}:8083"
  description = "Python application address"
}
