output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "sa_blob_endpoint" {
  value = azurerm_storage_account.SA.primary_blob_endpoint
}

output "vnet_id" {
  value = azurerm_virtual_network.example.id
}