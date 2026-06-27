moved {
  from = proxmox_virtual_environment_vm.vms["k8s-master-01"]
  to   = proxmox_virtual_environment_vm.vm["k8s-master-01"]
}

moved {
  from = proxmox_virtual_environment_vm.vms["k8s-worker-01"]
  to   = proxmox_virtual_environment_vm.vm["k8s-worker-01"]
}

moved {
  from = proxmox_virtual_environment_vm.nfs
  to   = proxmox_virtual_environment_vm.vm["nfs-01"]
}

moved {
  from = proxmox_virtual_environment_vm.nexus
  to   = proxmox_virtual_environment_vm.vm["nexus-01"]
}

moved {
  from = proxmox_virtual_environment_container.haproxy
  to   = proxmox_virtual_environment_container.lxc["haproxy-01"]
}