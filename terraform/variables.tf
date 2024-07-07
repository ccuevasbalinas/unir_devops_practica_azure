variable "location" {
  type        = string
  description = "Azure region where infrastructure will be created"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  default     = "UNIR"
  description = "Name of the resource group"
}