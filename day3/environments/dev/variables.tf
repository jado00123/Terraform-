variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "subnet_name" { type = string }
variable "vm_name" { type = string }
variable "vm_size" { type = string }
variable "admin_username" { type = string }

variable "allowed_ssh_ips" {
  type    = list(string)
  default = ["*"]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Owner       = "DevOps Team"
    Project     = "Terraform-Lab"
  }
}
