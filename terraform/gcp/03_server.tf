resource "google_compute_instance" "server" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  
  metadata = {
    # ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_path)}"
    enable-oslogin = "TRUE"
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
    user        = var.ssh_posix_user
    private_key = file(var.ssh_key_path)
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
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
