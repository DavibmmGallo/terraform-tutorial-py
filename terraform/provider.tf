terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.27.1"
    }
  }
}

provider "digitalocean" {
  token = "${token_digital_ocean}"
}

resource "digitalocean_droplet" "jenkins" {
  image  = "ubuntu-22-04-x64"
  name   = "jenkins"
  region = "ntc1"
  size   = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.journey.public_key]
}

data "digitalocean_ssh_key" "journey" {
  name = "journey"
  public_key = file("${HOME}/.ssh/id_rsa.pub")
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name   = "k8s_cluster"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.22.8-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

resource "local_file" "kube_config" {
  content = digitalocean_kubernetes_cluster.k8s_cluster.kube_config.0.raw_config
  filename = "kube.yaml"
}