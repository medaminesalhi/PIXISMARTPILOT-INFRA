locals {
  common_vm_tags  = ["terraform", "debian"]
  common_lxc_tags = ["terraform", "debian", "lxc"]

  vms = {
    "k8s-master-01" = {
      vm_id         = 101
      ip            = "172.16.0.11/24"
      cores         = 1
      memory        = 3072
      disk_size     = 20
      tags          = ["kubernetes", "control-plane"]
      startup_order = 10
      on_boot       = true
    }

    "k8s-worker-01" = {
      vm_id         = 102
      ip            = "172.16.0.12/24"
      cores         = 1
      memory        = 2048
      disk_size     = 20
      tags          = ["kubernetes", "worker"]
      startup_order = 20
      on_boot       = true
    }

    "k8s-worker-02" = {
      vm_id         = 103
      ip            = "172.16.0.13/24"
      cores         = 1
      memory        = 2048
      disk_size     = 20
      tags          = ["kubernetes", "worker"]
      startup_order = 21
      on_boot       = true
    }

    "nfs-01" = {
      vm_id         = 105
      ip            = "172.16.0.30/24"
      cores         = 1
      memory        = 2048
      disk_size     = 20
      tags          = ["nfs", "storage"]
      startup_order = 30
      on_boot       = true
    }

    "nexus-01" = {
      vm_id         = 106
      ip            = "172.16.0.40/24"
      cores         = 1
      memory        = 4096
      disk_size     = 25
      tags          = ["nexus", "repository"]
      startup_order = 40
      on_boot       = true
    }
  }

  containers = {
    "haproxy-01" = {
      vm_id         = 104
      ip            = "172.16.0.20/24"
      cores         = 1
      memory        = 1024
      swap          = 512
      disk_size     = 8
      tags          = ["haproxy", "loadbalancer"]
      startup_order = 5
      on_boot       = true
    }
  }
}