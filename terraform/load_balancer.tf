resource "azurerm_public_ip" "lbpip" {
  name                = "${var.rg_prefix}-ip"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.lb_ip_dns_name}"
}

resource "azurerm_lb" "lb" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  name                = "${var.rg_prefix}lb"
  location            = "${var.location}"


  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = "${azurerm_public_ip.lbpip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  resource_group_name = "${azurerm_resource_group.rg.name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "BackendPool1"
}

resource "azurerm_lb_nat_rule" "tcp" {
  resource_group_name            = "${azurerm_resource_group.rg.name}"
  loadbalancer_id                = "${azurerm_lb.lb.id}"
  name                           = "RDP-VM-${count.index}"
  protocol                       = "tcp"
  frontend_port                  = "${count.index + 50000}"
  backend_port                   = 3389
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  count                          = "${var.number_of_workstations}"
}

# resource "azurerm_lb_nat_rule" "tutor" {
#   resource_group_name            = "${azurerm_resource_group.rg.name}"
#   loadbalancer_id                = "${azurerm_lb.lb.id}"
#   name                           = "TUTOR-VM-${count.index}"
#   protocol                       = "ws"
#   frontend_port                  = "${count.index + 50100}"
#   backend_port                   = 3389
#   frontend_ip_configuration_name = "LoadBalancerFrontEnd"
#   count                          = "${var.number_of_tutors}"
# }
