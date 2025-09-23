
# Day2 Terraform Project - Azure Infrastructure

## Overview
This project demonstrates how to provision a basic Azure infrastructure using Terraform, including:
- Resource Group
- Virtual Network
- Subnet
- Public IP
- Network Interface
- Linux Virtual Machine

The project uses **variables** and **tfvars** for flexible configuration and **outputs** to easily reference created resources.

---

## Project Structure

```

day2/
├── main.tf          # Resource definitions
├── variables.tf     # Input variables
├── terraform.tfvars # Variable values
└── outputs.tf       # Output values



- `main.tf`: Defines all Azure resources.
- `variables.tf`: Declares input variables with description and type.
- `terraform.tfvars`: Provides actual values for variables.
- `outputs.tf`: Declares output values for easy reference.

---

## Setup Instructions

### 1. Prepare Environment
1. Install Terraform on your machine.
2. Authenticate with Azure CLI:
   ```bash
   az login


3. Verify your subscription:

   ```bash
   az account list
   ```

---

### 2. Writing Terraform Code

**Best Practices:**

* Start with **variables**: declare all configurable values in `variables.tf`.
* Assign values in `terraform.tfvars` instead of hardcoding.
* Define resources in `main.tf`.
* Separate outputs in `outputs.tf` for clarity.
* Use **descriptive names** for resources and variables.
* Keep code modular for reusability.

Example variable definition:

```hcl
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
```

Reference in `main.tf`:

```hcl
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
```

---

### 3. Apply Terraform

1. Initialize Terraform:

   ```bash
   terraform init
   ```
2. Validate configuration:

   ```bash
   terraform validate
   ```
3. Plan changes:

   ```bash
   terraform plan
   ```
4. Apply configuration:

   ```bash
   terraform apply
   ```

---

### 4. Outputs

After applying, Terraform will show outputs defined in `outputs.tf`:

```hcl
output "public_ip" {
  value = azurerm_public_ip.example.ip_address
}
```

Example usage:

```bash
ssh azureuser@<public_ip> -i ~/.ssh/id_rsa
```

---

## Notes & Tips

* **Variable Management**: Always declare variables in `variables.tf` and give default values only if necessary.
* **tfvars Usage**: Keep environment-specific values in `terraform.tfvars` for easy updates.
* **Clean Code**: Use proper indentation, descriptive names, and separate resource types logically.
* **Reusability**: Consider modularization for repeating resources in bigger projects.
* **Outputs**: Useful for quickly referencing VM IPs, usernames, or other important info.

---

## Summary

This project is structured for clarity and maintainability. By separating **variables**, **resource definitions**, and **outputs**, it becomes easy to:

* Update infrastructure values
* Reuse modules
* Share outputs with team members
* Keep Terraform code clean and readable

