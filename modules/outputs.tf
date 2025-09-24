output "resource_group_name" {
  value = azurerm_resource_group.internal-tf-lable-for-this-resource.name
}
output "location" {
  value = azurerm_resource_group.internal-tf-lable-for-this-resource.location
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet-lable.name
}
output "subnet_name" {
  value = azurerm_subnet.subnet-lable.name
}
output "public_ip_address" {
  value = azurerm_public_ip.public-ip-lable.ip_address
}
output "nsg_name" {
  value = azurerm_network_security_group.nsg-lable.name
}
output "nic_name" {
  value = azurerm_network_interface.nic-lable.name
}
output "vm_name" {
  value = azurerm_linux_virtual_machine.vm-lable.name
}
output "vm_size" {
  value = azurerm_linux_virtual_machine.vm-lable.size
}
