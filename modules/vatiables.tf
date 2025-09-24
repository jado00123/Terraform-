variable "aname-for-resource-groupe-variable" {
  type    = string
  default = "actual-name-in-azure"
  
}
variable "aname-for-location-variable" {
  type    = string
  default = "westeurope"
  
}

variable "aname-for-vnet-variable" {
  type    = string
  default = "vnet-name"
  
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string  
}