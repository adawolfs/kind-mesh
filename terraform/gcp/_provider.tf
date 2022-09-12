provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "kind-mesh"
  region      = "us-east1"
}