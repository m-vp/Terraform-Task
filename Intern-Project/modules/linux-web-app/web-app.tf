resource "azurerm_linux_web_app" "linux_web_app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.vnet_integration_subnet_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    container_registry_use_managed_identity = true
    vnet_route_all_enabled                  = true

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions

      content {
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
      }
    }

    application_stack {
      docker_image_name   = var.docker_image
    }
  }

  app_settings = var.app_settings
  tags         = var.tags
}

# resource "azurerm_role_assignment" "acr_pull" {
#   scope                = var.acr_id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_linux_web_app.linux_web_app.identity[0].principal_id
# }
