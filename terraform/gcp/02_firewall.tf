data "google_client_config" "current" {
}

resource "google_compute_firewall" "kind-mesh-rules" {
  project     = data.google_client_config.current.project
  name        = "kind-mesh-rule"
  network     = "default"
  description = "Enables traffic to exposed services"

  allow {
    protocol  = "tcp"
    ports     = ["80", "6443", "8080-8090"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kind-mesh"]
}