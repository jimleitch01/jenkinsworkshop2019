resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

# resource "azurerm_storage_account" "stor" {
#   name                     = "${var.dns_name}stor"
#   location                 = "${var.location}"
#   resource_group_name      = "${azurerm_resource_group.rg.name}"
#   account_tier             = "${var.storage_account_tier}"
#   account_replication_type = "${var.storage_replication_type}"
# }

resource "azurerm_availability_set" "avset" {
  name                         = "${var.dns_name}avset"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  platform_fault_domain_count  = 1
  platform_update_domain_count = 1
  managed                      = true
}
