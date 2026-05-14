# Auto-generate password if not provided
resource "random_password" "sql_admin" {
  length  = 16
  special = true
}

# Store credentials in Key Vault
resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "sql-admin-username"
  value        = var.administrator_login
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id

  depends_on = [random_password.sql_admin]
}

# resource "azurerm_key_vault_secret" "sql_connection_string" {
#   name         = "sql-connection-string"
#   value        = local.connection_string
#   key_vault_id = var.key_vault_id

#   depends_on = [azurerm_mssql_database.this]
# }