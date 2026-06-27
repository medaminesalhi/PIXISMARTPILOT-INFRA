resource "proxmox_virtual_environment_container" "lxc" {
  for_each = local.containers

  node_name   = var.proxmox_node
  vm_id       = each.value.vm_id
  description = "Managed by Terraform - ${each.key}"
  tags        = concat(local.common_lxc_tags, each.value.tags)

  started       = var.start_after_create
  start_on_boot = each.value.on_boot
  unprivileged  = true
  protection    = var.protection

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
    swap      = each.value.swap
  }

  disk {
    datastore_id = var.datastore_id
    size         = each.value.disk_size
  }

  operating_system {
    template_file_id = var.lxc_template_file_id
    type             = "debian"
  }

  initialization {
    hostname = each.key

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
      password = var.admin_password
      keys     = [trimspace(file(var.ssh_public_key_path))]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = var.network_bridge
    firewall = false
  }

  startup {
    order      = tostring(each.value.startup_order)
    up_delay   = "10"
    down_delay = "10"
  }

  wait_for_ip {
    ipv4 = true
  }
}