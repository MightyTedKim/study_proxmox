terraform {
  required_version = ">= 1.1.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

# Provider for Node 1
provider "proxmox" {
  alias             = "node1"
  pm_api_url        = "https://${var.proxmox_node1_host}:${var.proxmox_node1_port}/api2/json"
  pm_api_token_id   = "${var.proxmox_user}!${var.proxmox_token_name}"
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure   = true
}

# Provider for Node 2
provider "proxmox" {
  alias             = "node2"
  pm_api_url        = "https://${var.proxmox_node2_host}:${var.proxmox_node2_port}/api2/json"
  pm_api_token_id   = "${var.proxmox_user}!${var.proxmox_token_name}"
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure   = true
}
