variable "web_app_name" {
  type        = string
  description = "Name of the Azure Linux Web App."
}

variable "location" {
  type        = string
  description = "Azure region where the Web App will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the Web App will be created."
}

variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan used by the Linux Web App."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Enforces HTTPS-only traffic to the Web App."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Controls whether the Web App is publicly accessible over the internet."
}

variable "vnet_integration_subnet_id" {
  type        = string
  default     = null
  description = "Subnet ID used for outbound VNet integration so the app can access private resources such as Private Endpoints."
}

variable "docker_image" {
  type        = string
  description = "Name of the Docker image stored in Azure Container Registry."
}




variable "ip_restrictions" {
  type = list(object({
    name                      = string
    priority                  = number
    action                    = string
    ip_address                = optional(string)
    service_tag               = optional(string)
    virtual_network_subnet_id = optional(string)
  }))
  
  default = []

  description = "List of inbound access restriction rules for the Web App. Typically used for frontend apps to allow traffic only from sources like ."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application settings passed as environment variables to the containerized application."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to associate with the Web App resources."
}