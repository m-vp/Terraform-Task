variable "server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for SQL resources"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login for the SQL server"
  type        = string
  default     = "sqladmin"
}

variable "max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 32
}

variable "sku_name" {
  description = "SKU name for the SQL database"
  type        = string
  default     = "S1"
}

variable "key_vault_id" {
  description = "ID of the Key Vault to store credentials"
  type        = string
}

variable "tags" {
  description = "Tags to apply to SQL resources"
  type        = map(string)
  default     = {}
}