terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.23.0"
    }
  }
}

variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "pr1sm-hub" {
  name        = "pr1sm-hub"
  image       = "ubuntu-20.04"
  server_type = "cpx31"
  backups     = true
}