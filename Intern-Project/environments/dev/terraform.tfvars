# Environment and Project Configuration
environment  = "dev"
project_code = "aedp"
instance     = "002"
location     = "North Europe"

# Existing Resources
key_vault_name                = "shared-key-vault-az"
key_vault_resource_group_name = "rg-aedp-shared-inc-001"
acr_name                      = "acrsharedinc001"
acr_resource_group_name       = "rg-aedp-shared-inc-001"
acr_login_server              = "acrsharedinc001.azurecr.io"

# Networking
vnet_name          = "vnet-webapp-dev-001"
vnet_address_space = ["10.0.0.0/16"]

frontend_subnet_address_prefix         = "10.0.1.0/24"
backend_subnet_address_prefix          = "10.0.2.0/24"
private_endpoint_subnet_address_prefix = "10.0.3.0/24"

# App Service Plan - Changed to support VNet Integration
app_service_plan_name         = "asp-webapp-dev-001"
app_service_plan_sku          = "P1v3" # ✅ Supports VNet Integration
app_service_plan_worker_count = 1      # ✅ Reduced for cost optimization

# Web Apps
frontend_app_name     = "app-frontend-dev-002"
backend_app_name      = "app-backend-dev-002"
frontend_docker_image = "acrsharedinc001.azurecr.io/aed-frontend:v1"
backend_docker_image  = "acrsharedinc001.azurecr.io/aed-backend:v1"

# Frontend App Settings
frontend_app_settings = {
  "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  "WEBSITES_PORT"                       = "3000"
  "NODE_ENV"                            = "production"
  "PYTHONUNBUFFERED"                    = "1"
  "WEBSITE_DNS_SERVER"                  = "168.63.129.16"
}

# Backend App Settings
backend_app_settings = {
  "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  "WEBSITES_PORT"                       = "5000"
  "PORT"                                = "5000"
  "HOST"                                = "0.0.0.0"

  # Database configuration
  "DB_DRIVER"     = "ODBC Driver 18 for SQL Server"
  "DB_TRUST_CERT" = "no"

  # Python/Flask specific
  "PYTHONUNBUFFERED" = "1"
  "FLASK_ENV"        = "production"

  "WEBSITE_DNS_SERVER" = "168.63.129.16"
}

# SQL Database
sql_server_name         = "sql-webapp-dev-001"
sql_database_name       = "sqldb-webapp-dev"
sql_administrator_login = "sqladmin"
sql_sku_name            = "S1" # ✅ Reduced for cost optimization
sql_max_size_gb         = 5    # ✅ Reduced for cost optimization

# Tags
tags = {
  Environment = "dev"
  Project     = "webapp"
  Owner       = "platform-team"
  CostCenter  = "IT-001"
  CreatedBy   = "terraform"
  Application = "web-application"
}
