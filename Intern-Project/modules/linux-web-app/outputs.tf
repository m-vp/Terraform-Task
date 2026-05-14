output "web_app_id" {
  description = "Resource ID of the Azure Linux Web App."
  value       = azurerm_linux_web_app.linux_web_app.id
}

output "web_app_name" {
  description = "Name of the Azure Linux Web App."
  value       = azurerm_linux_web_app.linux_web_app.name
}

output "default_hostname" {
  description = "Default hostname of the Azure Linux Web App."
  value       = azurerm_linux_web_app.linux_web_app.default_hostname
}


output "principal_id" {
  description = "Managed Identity Principal ID of the Web App."
  value       = azurerm_linux_web_app.linux_web_app.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "Tenant ID of the system assigned identity"
  value       = azurerm_linux_web_app.linux_web_app.identity[0].tenant_id
}