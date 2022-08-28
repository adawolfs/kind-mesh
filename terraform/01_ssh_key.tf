## Create a new SSH key
resource "digitalocean_ssh_key" "adawolfs-do" {
  name       = "adawolfs@digitalocean.com"
  public_key = file("ssh-key.pub")
}

resource "digitalocean_ssh_key" "adawolfs" {
  name       = "adawolfs"
  public_key = file("ssh-key-adawolfs.pub")
}
