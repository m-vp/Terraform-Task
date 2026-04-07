resource_group_name  = "cmaz-w7gf0vkr-mod3-rg"
storage_account_name = "cmazw7gf0vkrsa"
vnet_name            = "cmaz-w7gf0vkr-mod3-vnet"

frontend_subnet_name = "frontend"
backend_subnet_name  = "backend"

tags = {
  Creator = "mattaparthi_venkatprashanth@epam.com"
}

location = "North Europe"

account_tier             = "Standard"
account_replication_type = "GRS"

vnet_address_space       = ["10.0.0.0/16"]
frontend_subnet_prefix   = ["10.0.1.0/24"]
backend_subnet_prefix    = ["10.0.2.0/24"]