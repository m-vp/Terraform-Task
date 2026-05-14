variable "environment" {
  description = "Target deployment environment"
  type        = string
  nullable    = false

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Allowed values are: dev, qa, prod."
  }
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
  nullable    = false
}

variable "project_code" {
  description = "Short project identifier used in naming convention"
  type        = string
  nullable    = false
}

variable "instance" {
  description = "Instance identifier used for uniqueness"
  type        = string
  nullable    = false
}


variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}