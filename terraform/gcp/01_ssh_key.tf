data "google_client_openid_userinfo" "me" {
}

resource "google_os_login_ssh_public_key" "ssh-key" {
  user =  data.google_client_openid_userinfo.me.email
  key = file("../ssh-key.pub")
}