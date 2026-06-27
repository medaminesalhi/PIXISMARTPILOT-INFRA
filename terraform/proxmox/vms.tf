resource "proxmox_virtual_environment_vm" "vm" {
  for_each = local.vms

  node_name   = var.proxmox_node
  vm_id       = each.value.vm_id
  name        = each.key
  description = "Managed by Terraform - ${each.key}"
  tags        = concat(local.common_vm_tags, each.value.tags)

  started         = var.start_after_create
  on_boot         = each.value.on_boot
  stop_on_destroy = true
  protection      = var.protection

  clone {
    vm_id        = var.template_vm_id
    full         = true
    datastore_id = var.datastore_id
    retries      = 3
  }

  cpu {
    cores = each.value.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = var.datastore_id
    interface    = "scsi0"
    size         = each.value.disk_size
  }

  agent {
    enabled = false
  }

  initialization {
    datastore_id = var.datastore_id

    dns {
      servers = var.dns_servers
    }

    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = var.gateway
      }
    }

    user_account {
      username = var.admin_user
      password = var.admin_password
      keys     = [trimspace(file(var.ssh_public_key_path))]
    }
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}

  startup {
    order      = tostring(each.value.startup_order)
    up_delay   = "20"
    down_delay = "20"
  }
}