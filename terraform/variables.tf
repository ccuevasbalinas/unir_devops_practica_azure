variable "location" {
  type        = string
  description = "Azure region where infrastructure will be created"
  default     = "North Europe"
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

variable "public_ip_name" {
  type        = string
  default     = "ccbcp2apip"
  description = "Name of the Public IP"
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

variable "load_balancer_name" {
  type        = string
  default     = "ccbcp2alb"
  description = "Name of the Load Balancer"
}

variable "storage_account_name" {
  type        = string
  default     = "ccbcp2asa"
  description = "Name of the Storage account"
}

variable "virtual_machine_name" {
  type        = string
  default     = "ccbcp2avm"
  description = "Name of the Virtual Machine"
}

variable "virtual_machine_size" {
  type        = string
  default     = "Standard_DS1_v2"
  description = "Size of the Virtual Machine: 3.5GB, 1 CPU"
}

variable "kubernetes_cluster_name" {
  type        = string
  default     = "ccbcp2aks"
  description = "Name of the Kubernetes cluster"
}