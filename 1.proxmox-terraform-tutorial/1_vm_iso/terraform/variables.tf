variable "target_node" {}


variable "pm_api_url" {
  type = string
}

variable "pm_api_token_id" {
  type = string
  sensitive = true
}

variable "pm_api_token_secret" {
  type = string
  sensitive = true
}
variable "vm_list" {
  type = list(object({
    name   = string
    vmid   = number
    ip     = string
    mac    = string
  }))
}

variable "proxmox_host" {
  type = string
}

variable "proxmox_port" {
  type = string
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_token_name" {
  type = string
}

variable "proxmox_token_secret" {
  type = string
  sensitive = true
}

variable "proxmox_node" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "vm_ip" {
  type = string
}

variable "vm_gateway" {
  type = string
}

variable "vm_mac" {
  type = string
}

variable "vm_memory" {
  type = number
}

variable "vm_cores" {
  type = number
}

variable "vm_storage" {
  type = string
}

variable "vm_iso" {
  type = string
}

# Node 1 Variables
variable "proxmox_node1_host" {
  type = string
}

variable "proxmox_node1_port" {
  type = string
}

variable "proxmox_node1_name" {
  type = string
}

# Node 2 Variables
variable "proxmox_node2_host" {
  type = string
}

variable "proxmox_node2_port" {
  type = string
}

variable "proxmox_node2_name" {
  type = string
}

# VM1 Variables
variable "vm1_name" {
  type = string
}

variable "vm1_id" {
  type = number
}

variable "vm1_ip" {
  type = string
}

variable "vm1_gateway" {
  type = string
}

variable "vm1_mac" {
  type = string
}

variable "vm1_memory" {
  type = number
}

variable "vm1_cores" {
  type = number
}

variable "vm1_storage" {
  type = string
}

variable "vm1_iso" {
  type = string
}

# VM2 Variables
variable "vm2_name" {
  type = string
}

variable "vm2_id" {
  type = number
}

variable "vm2_ip" {
  type = string
}

variable "vm2_gateway" {
  type = string
}

variable "vm2_mac" {
  type = string
}

variable "vm2_memory" {
  type = number
}

variable "vm2_cores" {
  type = number
}

variable "vm2_storage" {
  type = string
}

variable "vm2_iso" {
  type = string
}
