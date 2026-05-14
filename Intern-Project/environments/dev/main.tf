data "azurerm_key_vault" "existing" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_container_registry" "existing" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}


# Get current Terraform client configuration
data "azurerm_client_config" "current" {}

# Grant Terraform SP permission to write secrets to Key Vault
# resource "azurerm_role_assignment" "terraform_keyvault_secrets_officer" {
#   scope                = data.azurerm_key_vault.existing.id
#   role_definition_name = "Key Vault Secrets Officer"
#   principal_id         = data.azurerm_client_config.current.object_id
# }


# Resource Group
module "resource_group" {
  source = "../../modules/resource-group"
  
  environment = var.environment
  project_code = var.project_code
  instance = var.instance
  location = var.location

  tags     = var.tags
}


# Networking
module "network" {
  source = "../../modules/networking"
  
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space
  
  subnets = {
    frontend = {
      name           = "snet-frontend"
      address_prefix = var.frontend_subnet_address_prefix
      nsg_key        = "frontend"
      delegation = {
        name = "delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
    
    backend = {
      name           = "snet-backend"
      address_prefix = var.backend_subnet_address_prefix
      nsg_key        = "backend"
      delegation = {
        name = "delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
    
    private_endpoint = {
      name           = "snet-private-endpoint"
      address_prefix = var.private_endpoint_subnet_address_prefix
      nsg_key        = "private_endpoint"
    }
  }
  
  network_security_groups = {
    frontend = {
      name = "nsg-frontend"
      security_rules = [
        {
          name                       = "AllowHTTPS"
          priority                   = 1001
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowHTTP"
          priority                   = 1002
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        },
        {
          name                       = "DenyAllInbound"
          priority                   = 4096
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    
    backend = {
      name = "nsg-backend"
      security_rules = [
        {
          name                       = "AllowVNetInbound"
          priority                   = 1001
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "*"
        },
        {
          name                       = "DenyInternetInbound"
          priority                   = 1002
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        }
      ]
    }
    
    private_endpoint = {
      name = "nsg-private-endpoint"
      security_rules = [
        {
          name                       = "AllowVNetInbound"
          priority                   = 1001
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "*"
        },
        {
          name                       = "DenyAllInbound"
          priority                   = 4096
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
  
  tags = var.tags
}


# Private DNS Zones (centralized)
module "private_dns" {
  source = "../../modules/private-dns"
  
  resource_group_name = module.resource_group.resource_group_name
  vnet_id            = module.network.vnet_id
  
  dns_zones = [
    "privatelink.azurewebsites.net",
    "privatelink.database.windows.net"
  ]
  
  tags = var.tags
}

# App Service Plan
module "app_service_plan" {
  source = "../../modules/app-service-plan"
  
  app_service_plan_name              = var.app_service_plan_name
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  os_type            = "Linux"
  sku_name           = var.app_service_plan_sku

  worker_count       = var.app_service_plan_worker_count
  
  tags = var.tags
}


# SQL Database
module "sql" {
  source = "../../modules/sql"
  
  server_name         = var.sql_server_name
  database_name       = var.sql_database_name

  administrator_login = var.sql_administrator_login
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  
  key_vault_id = data.azurerm_key_vault.existing.id

  sku_name     = var.sql_sku_name
  max_size_gb   = var.sql_max_size_gb
  
  tags = var.tags
}



# Frontend Web App
module "frontend_web_app" {
  source = "../../modules/linux-web-app"
  
  web_app_name                = var.frontend_app_name
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  app_service_plan_id    = module.app_service_plan.app_service_plan_id

  https_only                    = true
  
  public_network_access_enabled = true
  vnet_integration_subnet_id    = module.network.frontend_subnet_id
  
  docker_image     = var.frontend_docker_image
  
  app_settings = merge(var.frontend_app_settings, {
    BACKEND_API_URL = "https://${var.backend_app_name}.azurewebsites.net"
  })
  
  tags = var.tags
  
}



# Backend Web App
module "backend_web_app" {
  source = "../../modules/linux-web-app"
  
  web_app_name                = var.backend_app_name
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  app_service_plan_id    = module.app_service_plan.app_service_plan_id

  https_only                    = true
  
  public_network_access_enabled = false
  vnet_integration_subnet_id    = module.network.backend_subnet_id
  
  docker_image     = var.backend_docker_image
  
  app_settings = merge(var.backend_app_settings, {

    # Database connection details
    "DB_SERVER"       = module.sql.server_fqdn  # This will be the private endpoint FQDN
    "DB_DATABASE"     = module.sql.database_name
    
    # Key Vault URL
    "KEY_VAULT_URL"   = data.azurerm_key_vault.existing.vault_uri

  })
  
  tags = var.tags
  
}

# Backend Private Endpoint
module "backend_private_endpoint" {
  source = "../../modules/private-endpoint"
  
  name                = "${var.backend_app_name}-pe"
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  subnet_id          = module.network.private_endpoint_subnet_id
  
  private_connection_resource_id = module.backend_web_app.web_app_id
  subresource_names             = ["sites"]
  private_dns_zone_id           = module.private_dns.dns_zone_ids["privatelink.azurewebsites.net"]
  
  tags = var.tags
}

# SQL Private Endpoint
module "sql_private_endpoint" {
  source = "../../modules/private-endpoint"
  
  name                = var.sql_server_name
  resource_group_name = module.resource_group.resource_group_name
  location           = var.location
  subnet_id          = module.network.private_endpoint_subnet_id
  
  private_connection_resource_id = module.sql.server_id
  subresource_names             = ["sqlServer"]
  private_dns_zone_id           = module.private_dns.dns_zone_ids["privatelink.database.windows.net"]
  
  tags = var.tags
}


# Role Assignments
resource "azurerm_role_assignment" "frontend_acr_pull" {
  scope                = data.azurerm_container_registry.existing.id
  role_definition_name = "AcrPull"
  principal_id         = module.frontend_web_app.principal_id
}

resource "azurerm_role_assignment" "backend_acr_pull" {
  scope                = data.azurerm_container_registry.existing.id
  role_definition_name = "AcrPull"
  principal_id         = module.backend_web_app.principal_id
}

# # Key Vault access for backend app
# resource "azurerm_key_vault_access_policy" "backend_app" {
#   key_vault_id = data.azurerm_key_vault.existing.id
#   tenant_id    = module.backend_web_app.identity_tenant_id
#   object_id    = module.backend_web_app.principal_id

#   secret_permissions = [
#     "Get",
#     "List"
#   ]
# }


# Output to verify Key Vault settings
output "key_vault_rbac_enabled" {
  description = "Whether RBAC is enabled on Key Vault"
  value       = data.azurerm_key_vault.existing.enable_rbac_authorization
}

# Key Vault Secrets User role for backend app (Modern approach)
resource "azurerm_role_assignment" "backend_keyvault_secrets_user" {
  scope                = data.azurerm_key_vault.existing.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.backend_web_app.principal_id
}