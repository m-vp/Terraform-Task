rg_name     = "cmaz-w7gf0vkr-mod4-rg"
vnet_name   = "cmaz-w7gf0vkr-mod4-vnet"
subnet_name = "frontend"

nic_name = "cmaz-w7gf0vkr-mod4-nic"

nsg_name              = "cmaz-w7gf0vkr-mod4-nsg"
nsg_inbound_http_rule = "AllowHTTP"
nsg_inbound_ssh_rule  = "AllowSSH"

public_ip_name = "cmaz-w7gf0vkr-mod4-pip"
dns_label_name = "cmaz-w7gf0vkr-mod4-nginx"

vm_name       = "cmaz-w7gf0vkr-mod4-vm"
vm_os_version = "ubuntu-24_04-lts"
vm_sku        = "Standard_B2s_v2"

Tags = {
  Creator = "mattaparthi_venkatprashanth@epam.com"
}

ip_config_name = "internal"