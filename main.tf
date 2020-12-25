terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.23.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "PR1SM"

    workspaces {
      name = "terraform-config"
    }
  }
}

variable "hcloud_token" {}
variable "ssh_key" {}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "pr1sm-hub" {
  name        = "pr1sm-hub"
  image       = "ubuntu-20.04"
  server_type = "cpx31"
  backups     = true
  user_data = << EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -
  EOF
}

resource "hcloud_ssh_key" "default" {
  name = "devenv jonas schultheiss"
  public_key = var.ssh_key
}