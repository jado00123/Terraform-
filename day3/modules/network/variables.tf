variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "subnet_name" { type = string }

variable "allowed_ssh_ips" {
  type    = list(string)
  default = ["*"] # للتجربة فقط
}

variable "tags" {
  type = map(string)
  default = {}
}
