variable "proxmox_endpoint" {
  type        = string
  description = "URL de l'API Proxmox. Exemple: https://100.64.79.100:8006/"
}

variable "proxmox_api_token" {
  type        = string
  description = "Token API Proxmox. Format: root@pam!terraform=xxxx"
  sensitive   = true
}

variable "proxmox_insecure" {
  type        = bool
  description = "Accepter le certificat self-signed de Proxmox."
  default     = true
}

variable "proxmox_node" {
  type        = string
  description = "Nom du node Proxmox."
  default     = "pve"
}

variable "template_vm_id" {
  type        = number
  description = "ID du template Debian cloud-init."
  default     = 9000
}

variable "lxc_template_file_id" {
  type        = string
  description = "Template LXC Debian dans Proxmox."
}

variable "datastore_id" {
  type        = string
  description = "Datastore Proxmox pour les disques."
  default     = "local-lvm"
}

variable "network_bridge" {
  type        = string
  description = "Bridge réseau Proxmox."
  default     = "vmbr1"
}

variable "gateway" {
  type        = string
  description = "Passerelle du réseau interne."
  default     = "172.16.0.1"
}

variable "dns_servers" {
  type        = list(string)
  description = "Serveurs DNS."
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "admin_user" {
  type        = string
  description = "Utilisateur créé par cloud-init dans les VMs."
  default     = "user"
}

variable "admin_password" {
  type        = string
  description = "Mot de passe initial temporaire."
  sensitive   = true
}

variable "ssh_public_key_path" {
  type        = string
  description = "Chemin local vers la clé publique SSH."
}

variable "start_after_create" {
  type        = bool
  description = "Démarrer les machines après création."
  default     = true
}

variable "protection" {
  type        = bool
  description = "Protection Proxmox contre suppression accidentelle."
  default     = false
}