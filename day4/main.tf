terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.45.0"
    }
  }
  
}

provider "azurerm" {
  features {}

  subscription_id = "82aad9bf-5e07-4453-a938-c9c1279755bb" # استبدلها من az account list
  tenant_id       = "53026bc7-1a33-4029-aad2-933633d4780a" # استبدلها من az account list
  
}


module "vm_dev" {
  source = "./modules"
  aname-for-resource-groupe-variable = "DevVNet"
  aname-for-location-variable = "westeurope"
  aname-for-vnet-variable = "vnet-name"
  vm_size = "Standard_B1s"
  
}