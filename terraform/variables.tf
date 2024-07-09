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

variable "availability_set_name" {
  type        = string
  default     = "ccbcp2aas"
  description = "Name of Availability Set"
}

variable "virtual_network_name" {
  type        = string
  default     = "ccbcp2avn"
  description = "Name of the Virtual Network"
}

variable "subnet_name" {
  type        = string
  default     = "ccbcp2asub"
  description = "Name of the Subnet"
}

variable "network_interface_name" {
  type        = string
  default     = "ccbcp2ani"
  description = "Name of the Network Interface"
}

variable "network_security_group_name" {
  type        = string
  default     = "ccbcp2ansg"
  description = "Name of the Network Security Group"
}