terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestoragejihad2025"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "82aad9bf-5e07-4453-a938-c9c1279755bb" # استبدلها من az account list
  tenant_id       = "53026bc7-1a33-4029-aad2-933633d4780a" # استبدلها من az account list

}

resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = azurerm_resource_group.dev.name
  location            = var.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  allowed_ssh_ips     = var.allowed_ssh_ips
  tags                = var.tags
}

module "compute" {
  source              = "../../modules/compute"
  resource_group_name = azurerm_resource_group.dev.name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  subnet_id           = module.network.subnet_id
  nsg_id              = module.network.nsg_id
  tags                = var.tags
}
