variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "North Europe"
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "frontend_subnet_name" {
  description = "The name of the frontend subnet"
  type        = string
}

variable "backend_subnet_name" {
  description = "The name of the backend subnet"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
}


variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
}

variable "account_replication_type" {
  description = "Storage replication type"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = list(string)
}

variable "frontend_subnet_prefix" {
  description = "Address prefix for frontend subnet"
  type        = list(string)
}

variable "backend_subnet_prefix" {
  description = "Address prefix for backend subnet"
  type        = list(string)
}