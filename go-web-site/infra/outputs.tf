output "container_ipv4" {
  value       = azurerm_container_group.aci.ip_address
  description = "Публичный IP-адрес ACI"
}

output "container_fqdn" {
  value       = "http://${azurerm_container_group.aci.fqdn}:${var.container_port}"
  description = "Полный URL для доступа к приложению"
}
