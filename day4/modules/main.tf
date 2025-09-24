

resource "azurerm_resource_group" "internal-tf-lable-for-this-resource" {
  name     = var.aname-for-resource-groupe-variable
  location = var.aname-for-location-variable
}

resource "azurerm_virtual_network" "vnet-lable" {
  name                = var.aname-for-vnet-variable
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.internal-tf-lable-for-this-resource.location
  resource_group_name = azurerm_resource_group.internal-tf-lable-for-this-resource.name
 
}

resource "azurerm_subnet" "subnet-lable" {
  name                 = "subnet-name"
  resource_group_name  = azurerm_resource_group.internal-tf-lable-for-this-resource.name
  virtual_network_name = azurerm_virtual_network.vnet-lable.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "public-ip-lable" {
  name                     = "public-ip-name"
  resource_group_name      = azurerm_resource_group.internal-tf-lable-for-this-resource.name
  location                 = azurerm_resource_group.internal-tf-lable-for-this-resource.location
  allocation_method        = "Static"
}

resource "azurerm_network_security_group" "nsg-lable" {
  name                = "nsg-name"
  location            = azurerm_resource_group.internal-tf-lable-for-this-resource.location
  resource_group_name = azurerm_resource_group.internal-tf-lable-for-this-resource.name
}

resource "azurerm_network_security_rule" "nsg-rule-lable" {
  name                        = "SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.internal-tf-lable-for-this-resource.name
  network_security_group_name = azurerm_network_security_group.nsg-lable.name
}

resource "azurerm_network_interface" "nic-lable" {
  name                = "nic-name"
  location            = azurerm_resource_group.internal-tf-lable-for-this-resource.location
  resource_group_name = azurerm_resource_group.internal-tf-lable-for-this-resource.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-lable.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip-lable.id
  }
}
    
resource "azurerm_linux_virtual_machine" "vm-lable" {
  name                = "vm-name"
  resource_group_name = azurerm_resource_group.internal-tf-lable-for-this-resource.name
  location            = azurerm_resource_group.internal-tf-lable-for-this-resource.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-lable.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # تأكد من وجود المفتاح العام في هذا المسار
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
}












