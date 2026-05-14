variable "resource_group_name" {
  description = "The name of the resource group in which to create the App Service Plan."
  type        = string
}

variable "location" {
  description = "The location/region where the App Service Plan should be created."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "os_type" {
  description = "The operating system type for the App Service Plan. Possible values are 'Windows' or 'Linux'."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan. Possible values include 'F1', 'D1', 'B1', 'B2', 'B3', 'S1', 'S2', 'S3', 'P1v2', 'P2v2', and 'P3v2'."
  type        = string
}

variable "worker_count" {
  description = "The number of workers to be allocated for the App Service Plan."
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to assign to the App Service Plan."
  type        = map(string)
}