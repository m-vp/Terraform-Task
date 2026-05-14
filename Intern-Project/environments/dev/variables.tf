# Environment and Project Configuration
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_code" {
  description = "Project code for resource naming"
  type        = string
}

variable "instance" {
  description = "Instance identifier for resource naming"
  type        = string
  default     = "001"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

# Existing Resources
variable "key_vault_name" {
  description = "Name of the existing Key Vault"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "Resource group name of the existing Key Vault"
  type        = string
}

variable "acr_name" {
  description = "Name of the existing Azure Container Registry"
  type        = string
}

variable "acr_resource_group_name" {
  description = "Resource group name of the existing Azure Container Registry"
  type        = string
}

variable "acr_login_server" {
  description = "Login server URL of the existing Azure Container Registry"
  type        = string
}

# Networking
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "frontend_subnet_address_prefix" {
  description = "Address prefix for frontend subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "backend_subnet_address_prefix" {
  description = "Address prefix for backend subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_endpoint_subnet_address_prefix" {
  description = "Address prefix for private endpoint subnet"
  type        = string
  default     = "10.0.3.0/24"
}

# App Service Plan
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "P1v3"
}

variable "app_service_plan_worker_count" {
  description = "Number of workers for the App Service Plan"
  type        = number
  default     = 1
}

# Web Apps
variable "frontend_app_name" {
  description = "Name of the frontend web app"
  type        = string
}

variable "backend_app_name" {
  description = "Name of the backend web app"
  type        = string
}

variable "frontend_docker_image" {
  description = "Docker image for frontend app (without registry URL)"
  type        = string
}

variable "backend_docker_image" {
  description = "Docker image for backend app (without registry URL)"
  type        = string
}

variable "frontend_app_settings" {
  description = "App settings for frontend web app"
  type        = map(string)
  default     = {}
}

variable "backend_app_settings" {
  description = "App settings for backend web app"
  type        = map(string)
  default     = {}
}

# SQL Database
variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "sql_administrator_login" {
  description = "Administrator login for the SQL server"
  type        = string
  default     = "sqladmin"
}

variable "sql_sku_name" {
  description = "SKU name for the SQL database"
  type        = string
  default     = "S1"
}

variable "sql_max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 32
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "web-app"
  }
}