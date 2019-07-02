resource "azurerm_virtual_network" "vnet" {
  name                = "var.virtual_network_name"
  location            = "var.location"
  resource_group_name = "azurerm_resource_group.rg.name"
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.rg_prefix}subnet"
  virtual_network_name = "azurerm_virtual_network.vnet.name"
  resource_group_name  = "azurerm_resource_group.rg.name"
  address_prefix       = "var.subnet_prefix"
}

