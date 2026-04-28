output "key_vault_id" {
  description = "ID of the created Key Vault"
  value       = azurerm_key_vault.kv.id
}