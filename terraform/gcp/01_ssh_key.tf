data "google_client_openid_userinfo" "me" {
}

data "google_project" "project" {
}

resource "google_os_login_ssh_public_key" "cache" {
  user    = data.google_client_openid_userinfo.me.email
  key     = file("../ssh-key.pub")
  project = data.google_project.project.number
  lifecycle {
    prevent_destroy = false
  }
}

output "ssh_public_key" {
  value = google_os_login_ssh_public_key.cache
}