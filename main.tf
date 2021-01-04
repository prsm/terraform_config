terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.23.0"
    }

    nomad = {
      source  = "hashicorp/nomad"
      version = "1.4.11"
    }

    consul = {
      source = "hashicorp/consul"
      version = "2.10.1"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "PR1SM"

    workspaces {
      name = "terraform-config"
    }
  }
}

data "template_file" "user_data" {
  template = file("./cloud_init.yaml")
}

variable "hcloud_token" {}
variable "ssh_key" {}
variable "nomad_address" {}

provider "hcloud" {
  token = var.hcloud_token
}

provider "consul" {
  datacenter = "dc1"
}

resource "hcloud_server" "pr1sm-hub" {
  name        = "pr1sm-hub"
  image       = "ubuntu-20.04"
  server_type = "cpx31"
  backups     = true
  location    = "nbg1"
  user_data   = data.template_file.user_data.rendered
}

resource "hcloud_ssh_key" "default" {
  name       = "devenv jonas schultheiss"
  public_key = var.ssh_key
}

provider "nomad" {
  address = var.nomad_address
  region  = "global"
}

resource "nomad_job" "kratos" {
  jobspec = file("./nomad/kratos.nomad")
}
resource "nomad_job" "kratos-psql" {
  jobspec = file("./nomad/kratos-psql.nomad")
}
