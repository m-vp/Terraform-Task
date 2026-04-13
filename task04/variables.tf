variable "rg_name" {
  type        = string
  description = "Name of Resource Group"
  default     = "cmaz-w7gf0vkr-mod4-rg"
}

variable "vnet_name" {
  type        = string
  description = "Name of Vnet"
  default     = "cmaz-w7gf0vkr-mod4-vnet"
}

variable "subnet_name" {
  type        = string
  description = "Name of Subnet"
  default     = "frontend"
}


variable "nic_name" {
  type        = string
  description = "Name of Nic"
  default     = "cmaz-w7gf0vkr-mod4-nic"
}

variable "nsg_name" {
  type        = string
  description = "Name of NSG"
  default     = "cmaz-w7gf0vkr-mod4-nsg"
}

variable "nsg_inbound_http_rule" {
  type        = string
  description = "inbound http rule name"
  default     = "AllowHTTP"
}

variable "nsg_inbound_ssh_rule" {
  type        = string
  description = "inbound ssh rule name"
  default     = "AllowSSH"
}

variable "public_ip_name" {
  type        = string
  description = "public ip name"
  default     = "cmaz-w7gf0vkr-mod4-pip"
}

variable "dns_label_name" {
  type        = string
  description = "dns label name"
  default     = "cmaz-w7gf0vkr-mod4-nginx"
}

variable "vm_name" {
  type        = string
  description = "vm name"
  default     = "cmaz-w7gf0vkr-mod4-vm"
}

variable "vm_os_version" {
  type        = string
  description = "vm version"
  default     = "ubuntu-24_04-lts"
}

variable "vm_sku" {
  type        = string
  description = "vm sku"
  default     = "Standard_B2s_v2"
}

variable "Tags" {
  type        = map(string)
  description = "tags"
  default = {
    "Creator" = "mattaparthi_venkatprashanth@epam.com"
  }
}

variable "vm_password" {
  description = "VM admin password"
  type        = string
  sensitive   = true
}

variable "ip_config_name" {
  description = "IP configuration name"
  type        = string
  default     = "internal"
}