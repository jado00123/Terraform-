output "public_ip" {
  value = azurerm_public_ip.this.ip_address
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.this.ip_address} -i ~/.ssh/id_rsa"
}
