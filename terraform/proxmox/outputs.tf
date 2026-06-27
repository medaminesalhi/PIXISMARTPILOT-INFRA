output "vm_inventory" {
  description = "Inventaire des VMs."

  value = {
    for name, vm in proxmox_virtual_environment_vm.vm :
    name => {
      vm_id = vm.vm_id
      ip    = split("/", local.vms[name].ip)[0]
      tags  = concat(local.common_vm_tags, local.vms[name].tags)
    }
  }
}

output "lxc_inventory" {
  description = "Inventaire des conteneurs LXC."

  value = {
    for name, lxc in proxmox_virtual_environment_container.lxc :
    name => {
      vm_id = lxc.vm_id
      ip    = split("/", local.containers[name].ip)[0]
      tags  = concat(local.common_lxc_tags, local.containers[name].tags)
    }
  }
}

output "ansible_inventory_preview" {
  description = "Aperçu de l'inventaire Ansible."

  value = <<EOT
[k8s_control_plane]
k8s-master-01 ansible_host=${split("/", local.vms["k8s-master-01"].ip)[0]}

[k8s_workers]
k8s-worker-01 ansible_host=${split("/", local.vms["k8s-worker-01"].ip)[0]}
k8s-worker-02 ansible_host=${split("/", local.vms["k8s-worker-02"].ip)[0]}

[nfs]
nfs-01 ansible_host=${split("/", local.vms["nfs-01"].ip)[0]}

[nexus]
nexus-01 ansible_host=${split("/", local.vms["nexus-01"].ip)[0]}

[loadbalancer]
haproxy-01 ansible_host=${split("/", local.containers["haproxy-01"].ip)[0]}

[all:vars]
ansible_user=${var.admin_user}
EOT
}