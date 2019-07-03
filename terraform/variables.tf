variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
  default     = "jws2019-rg"
}

variable "rg_prefix" {
  description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."
  default     = "jws2019"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  default     = "defaulthostname"
}

variable "dns_name" {
  description = " Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = "jws2019"
}

variable "lb_ip_dns_name" {
  description = "DNS for Load Balancer IP"
  default     = "jws2019"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "westeurope"
}

variable "virtual_network_name" {
  description = "The name for the virtual network."
  default     = "jws2019-vnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "storage_account_tier" {
  description = "Defines the Tier of storage account to be created. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the Replication Type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  # default     = "Standard_D2s_v3"
  default = "Standard_B2ms"
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "2019-Datacenter"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "administrator user name"
  default     = "workshop"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  default     = ""
}

variable "number_of_workstations" {
  description = "number of Windows workstations to be created"
  default     = "18"
}

variable "number_of_tutors" {
  description = "number of Tutors workstations to be created"
  default     = "1"
}


variable "number_of_jenkins" {
  description = "number of Jenkins hosts to be created"
  default     = "1"
}

variable "number_of_build_hosts" {
  description = "number of builder hosts to be created"
  default     = "1"
}

variable "number_of_app_hosts" {
  description = "number of apphosts to be created"
  default     = "1"
}

variable "dnsimple_account" {
  description = "dnsimple_account"
  default     = ""
}

variable "dnsimple_token" {
  description = "dnsimple_token"
  default     = ""
}

