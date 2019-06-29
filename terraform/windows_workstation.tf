resource "azurerm_virtual_machine" "ws" {
    name                              = "ws-${count.index}"
    location                          = "${var.location}"
    resource_group_name               = "${azurerm_resource_group.rg.name}"
    #   availability_set_id   = "${azurerm_availability_set.avset.id}"
    vm_size                           = "${var.vm_size}"
    network_interface_ids             = ["${element(azurerm_network_interface.windows-workstation-nic.*.id, count.index)}"]
    count                             = "${var.number_of_workstations}"
    delete_os_disk_on_termination     = true
    delete_data_disks_on_termination  = true

    storage_image_reference {
        publisher = "${var.image_publisher}"
        offer     = "${var.image_offer}"
        sku       = "${var.image_sku}"
        version   = "${var.image_version}"
    }

    storage_os_disk {
        name          = "ws-disk${count.index}"
        create_option = "FromImage"
        caching       = "ReadWrite"
    }


    os_profile {
        computer_name  = "ws-${count.index}"
        admin_username = "${var.admin_username}"
        admin_password = "${var.admin_password}"
    }

    os_profile_windows_config {
        provision_vm_agent = true
    }
}

resource "azurerm_network_interface" "windows-workstation-nic" {
    name                = "windows-workstation-nic${count.index}"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    count               = "${var.number_of_workstations}"

    ip_configuration {
        name                                    = "ipconfig${count.index}"
        subnet_id                               = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation           = "Dynamic"
        # load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.backend_pool.id}"]
        # load_balancer_inbound_nat_rules_ids     = ["${element(azurerm_lb_nat_rule.tcp.*.id, count.index)}"]

    }
}

resource "azurerm_network_interface_nat_rule_association" "windows-workstation-nic" {
    # network_interface_id  = "${azurerm_network_interface.windows-workstation-nic.id}"
    network_interface_id  = "${element(azurerm_network_interface.windows-workstation-nic.*.id, count.index)}"
    # network_interface_id  = "${azurerm_network_interface.test.id}"
    ip_configuration_name = "ipconfig${count.index}"
    nat_rule_id           = "${element(azurerm_lb_nat_rule.tcp.*.id, count.index)}"
}
