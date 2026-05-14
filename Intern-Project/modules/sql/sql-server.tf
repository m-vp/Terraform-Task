resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = random_password.sql_admin.result
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# # Threat detection policy
# resource "azurerm_mssql_server_security_alert_policy" "this" {
#   count = var.enable_threat_detection ? 1 : 0

#   resource_group_name = var.resource_group_name
#   server_name         = azurerm_mssql_server.this.name
#   state               = "Enabled"
#   retention_days      = 30
# }