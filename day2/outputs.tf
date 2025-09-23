output "public_ip" {
  value = azurerm_public_ip.example.ip_address
}
output "admin_username" {
  value = var.admin_username
}
output "vm_size" {
  value = var.vm_size
}
output "vm_name" {
  value = var.vm_name
}
output "resource_group_name" {
  value = var.resource_group_name
}
output "location" {
  value = var.location
}
output "vnet_name" {
  value = var.vnet_name
}
output "subnet_name" {
  value = var.subnet_name
}
output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.example.ip_address} -i ~/.ssh/id_rsa"
}
