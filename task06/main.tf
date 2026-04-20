data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "sql" {
  source = "./modules/sql"

  sql_server_name = local.sql_server_name

  resource_group_name = local.rg_name
  location            = azurerm_resource_group.rg.location

  kv-secret-name-sql-admin-username = var.kv-secret-name-sql-admin-username
  kv-secret-name-sql-admin-password = var.kv-secret-name-sql-admin-password

  allowed_ip_address   = var.allowed_ip_address
  sql_database_name    = local.sql_db_name
  sql_db_service_model = var.sql_sku

  key_vault_id = data.azurerm_key_vault.kv.id

  tags = var.tags

}

module "webapp" {
  source = "./modules/webapp"

  asp_name            = local.asp_name
  resource_group_name = local.rg_name
  location            = azurerm_resource_group.rg.location
  asp_sku             = var.asp_sku
  os_type             = var.os_type

  webapp_name           = local.app_name
  dotnet_version        = var.dotnet_version
  sql_connection_string = module.sql.sql_connection_string

  tags = var.tags
}