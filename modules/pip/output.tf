output "public_ip_id" {
  description = "The ID of the public IP resource"
  value       = azurerm_public_ip.public_ip.id
}

output "public_ip_address" {
  description = "The actual public IP address"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_name" {
  description = "The name of the public IP resource"
  value       = azurerm_public_ip.public_ip.name
}
