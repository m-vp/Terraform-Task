variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "storage_account_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "frontend_subnet_name" {
  type = string
}

variable "backend_subnet_name" {
  type = string
}

variable "tags" {
  type = map(string)
}