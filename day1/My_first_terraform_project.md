terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxx" # استبدلها من az account list
  tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxx" # استبدلها من az account list

}


resource "azurerm_resource_group" "example" {
  name     = "example-resources1"
  location = "EAST US"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                     = "example_ip"
  resource_group_name = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  allocation_method        = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}



# Terraform Project - Day 1

This is my first Terraform project on Azure. 
The goal was to provision a simple environment with a **Resource Group**, **Virtual Network**, **Subnet**, **Network Interface**, **Public IP**, and a **Virtual Machine (Ubuntu 22.04)**.


## 📌 Stage 1: Environment Setup
- Installed **Terraform** on Windows.
- Configured authentication with Azure using:
  az login

* Verified subscription and tenant IDs with:

  az account list
  


## 📌 Stage 2: Writing the Code

* Created `main.tf` with:

  * **Provider block** for `azurerm`.
  * **Resource Group**.
  * **Virtual Network** and **Subnet**.
  * **Network Interface**.
  * **Public IP (Static)** for SSH access.
  * **Virtual Machine** (Ubuntu 22.04 LTS).


## 📌 Stage 3: Applying the Configuration

* Initialized and applied Terraform:

  terraform init
  terraform plan
  terraform apply
  
* Verified outputs (Public and Private IPs of the VM).


## 📌 Stage 4: Issues and Fixes

### 1. Provider version mismatch

**Error:**

text
locked provider registry.terraform.io/hashicorp/azurerm 4.45.0 does not match configured version 3.0.0


**Fix:**
Run `terraform init -upgrade` and update provider version to `~>4.45.0`.


### 2. Unsupported argument in provider

**Error:**

text
resource_provider_registrations = "none" is not expected here


**Fix:**
Removed the unsupported argument from the provider block.


### 3. VM SKU not available

**Error:**

text
SkuNotAvailable: The requested VM size Standard_DS1_v2 is not available in location 'westeurope'.


**Fix:**
Changed to a smaller available size: `Standard_B1s`.


### 4. Resource group deletion failed

**Error:**

text
The Resource Group still contains Resources (disk myosdisk1)


**Fix:**
Added:

hcl
features {
  resource_group {
    prevent_deletion_if_contains_resources = false
  }
}


so Terraform can delete resource groups even if disks remain.


### 5. SSH connection timeout

**Error:**

text
ssh: connect to host <public-ip> port 22: Connection timed out


**Fix:**
Opened port **22** using a **Network Security Group (NSG)** and associated it with the VM’s NIC.


## 📌 Stage 5: Destroying the Infrastructure

* Cleaned up resources with:

  terraform destroy
  
* Some deletions (especially storage/disk) took longer, which is expected in Azure.


## ✅ Summary

This project demonstrated how to:

* Set up Terraform with Azure.
* Create core networking and VM resources.
* Troubleshoot common Terraform + Azure issues.
* Destroy resources safely.



