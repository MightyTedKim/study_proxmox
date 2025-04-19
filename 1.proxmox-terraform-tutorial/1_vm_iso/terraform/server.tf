# VM on Node 1
resource "proxmox_vm_qemu" "vm1" {
  provider = proxmox.node1
  name          = var.vm1_name
  desc          = "VM with static IP ${var.vm1_ip}"
  target_node   = var.proxmox_node1_name
  vmid          = var.vm1_id

  # PXE 부팅을 사용하려면 clone을 사용하지 않습니다.
  pxe           = false
  agent         = 0
  memory        = var.vm1_memory
  cores         = var.vm1_cores
  sockets       = 1
  kvm           = true
  bios          = "seabios"
  startup       = ""
  numa          = false
  boot = "order=virtio0;net0;ide2"  # 디스크를 첫 번째로 설정
  os_type       = "Linux 6.x - 2.6 Kernel"
  qemu_os       = "l26"
  scsihw = "virtio-scsi-single"  # <-- (Optional) Change the SCSI controller type, since Proxmox 7.3, virtio-scsi-single is the default one         
  hotplug       = "network,disk,usb"
  automatic_reboot = false
  # -- Disk Settings

  
  disks {  # <-- ! changed in 3.x.x
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/${var.vm1_iso}"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          storage   = var.vm1_storage
          size      = "20G"  # <-- Change the desired disk size, ! since 3.x.x size change will trigger a disk resize
          iothread  = true  # <-- (Optional) Enable IOThread for better disk performance in virtio-scsi-single
          replicate = false  # <-- (Optional) Enable for disk replication
        }
      }
    }
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "vmbr0"
    firewall  = false
    link_down = false
    macaddr = var.vm1_mac
  }
  smbios {
    family       = "VM"
    manufacturer = "Hashibrown"
    product      = "Terraform"
    sku          = "dQw4w9WgXcQ"
    uuid         = "5b710d2f-4ea2-4d49-9eaa-c18392fd734d"
    version      = "v1.0"
    serial       = "ABC123"
  }
}

# VM on Node 2
resource "proxmox_vm_qemu" "vm2" {
  provider = proxmox.node2
  name          = var.vm2_name
  desc          = "VM with static IP ${var.vm2_ip}"
  target_node   = var.proxmox_node2_name
  vmid          = var.vm2_id

  # PXE 부팅을 사용하려면 clone을 사용하지 않습니다.
  pxe           = false
  agent         = 0
  memory        = var.vm2_memory
  cores         = var.vm2_cores
  sockets       = 1
  kvm           = true
  bios          = "seabios"
  startup       = ""
  numa          = false
  boot = "order=virtio0;net0;ide2"
  os_type       = "Linux 6.x - 2.6 Kernel"
  qemu_os       = "l26"
  scsihw = "virtio-scsi-single"
  hotplug       = "network,disk,usb"
  automatic_reboot = false
  # -- Disk Settings

  
  disks {  # <-- ! changed in 3.x.x
    ide {
      ide2 {
        cdrom {
          iso = "local:iso/${var.vm2_iso}"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          storage   = var.vm2_storage
          size      = "20G"  # <-- Change the desired disk size, ! since 3.x.x size change will trigger a disk resize
          iothread  = true  # <-- (Optional) Enable IOThread for better disk performance in virtio-scsi-single
          replicate = false  # <-- (Optional) Enable for disk replication
        }
      }
    }
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "vmbr0"
    firewall  = false
    link_down = false
    macaddr = var.vm2_mac
  }
  smbios {
    family       = "VM"
    manufacturer = "Hashibrown"
    product      = "Terraform"
    sku          = "dQw4w9WgXcQ"
    uuid         = "5b710d2f-4ea2-4d49-9eaa-c18392fd734e"
    version      = "v1.0"
    serial       = "ABC124"
  }
}