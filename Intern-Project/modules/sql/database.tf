resource "azurerm_mssql_database" "this" {
  name      = var.database_name
  server_id = azurerm_mssql_server.this.id

  sku_name    = var.sku_name
  max_size_gb = var.max_size_gb

  # short_term_retention_policy {
  #   retention_days = var.backup_retention_days
  # }

  tags = var.tags
}

# Database auditing
# resource "azurerm_mssql_database_extended_auditing_policy" "this" {
#   database_id            = azurerm_mssql_database.this.id
#   enabled                = true
#   retention_in_days      = 30
# }