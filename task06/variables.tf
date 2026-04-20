variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

# Existing Key Vault
variable "key_vault_name" {
  description = "key vault name"
  type = string
}

variable "key_vault_rg" {
  description = "name of rg, key vault exists in"
  type = string
}

# SQL
variable "sql_sku" {
  description = "SQL Database SKU"
  type        = string
}

variable "allowed_ip_address" {
  description = "firewall values for db"
  type        = map(string)
}

variable "kv-secret-name-sql-admin-username" {
  type        = string
  description = "secret name for sql admin username"
}

variable "kv-secret-name-sql-admin-password" {
  type        = string
  description = "secret name for sql admin password"
}


# App Service Plan
variable "asp_sku" {
  type        = string
  description = "sp aku"
}

# Web App
variable "dotnet_version" {
  type        = string
  description = "dotnet version"
}

variable "os_type" {
  type        = string
  description = "os type"
}
