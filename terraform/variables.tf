variable "location" {
  type        = string
  description = "Azure region where infrastructure will be created"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  default     = "ccbcp2arg"
  description = "Name of the resource group"
}

variable "container_registry_name" {
  type        = string
  default     = "ccbcp2acr"
  description = "Name of the Azure Container Registry"
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "SKU"
}