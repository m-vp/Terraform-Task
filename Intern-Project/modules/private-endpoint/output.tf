output "private_endpoint_id" {
  description = "ID of the private endpoint"
  value       = azurerm_private_endpoint.this.id
}

output "private_endpoint_ip" {
  description = "Private IP address of the private endpoint"
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}