variable "name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the private endpoint"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID of the resource to connect privately"
  type        = string
}

variable "subresource_names" {
  description = "List of subresource names for the private endpoint"
  type        = list(string)
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}