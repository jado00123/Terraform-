
HEAD

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



fd06b15 (Prepare day1 folder and README)