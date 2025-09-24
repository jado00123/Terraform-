variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vm_name" { type = string }
variable "vm_size" { type = string }
variable "admin_username" { type = string }

variable "subnet_id" { type = string }
variable "nsg_id" { type = string }

variable "tags" {
  type = map(string)
  default = {}
}
