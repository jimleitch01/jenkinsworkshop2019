resource "azurerm_virtual_machine" "tutor" {
  name                = "tutor-${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  availability_set_id              = "${azurerm_availability_set.avset.id}"
  vm_size                          = "Standard_D2s_v3"
  network_interface_ids            = ["${element(azurerm_network_interface.windows-tutor-nic.*.id, count.index, )}"]
  count                            = "${var.number_of_tutors}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "tutor-disk${count.index}"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }

  os_profile {
    computer_name  = "tutor-${count.index}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    # additional_unattend_config {
    #   pass         = "oobeSystem"
    #   component    = "Microsoft-Windows-Shell-Setup"
    #   setting_name = "FirstLogonCommands"
    #   content      = "${file("FirstLogonCommands.xml")}"
    # }
  }
}

resource "azurerm_network_interface" "windows-tutor-nic" {
  name                = "windows-tutor-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = "${var.number_of_tutors}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"

    # public_ip_address_id = ["${element(azurerm_public_ip.windows-tutor-nic-ip.*.id, count.index, )}"]

    # load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.backend_pool.id}"]
    # load_balancer_inbound_nat_rules_ids     = ["${element(azurerm_lb_nat_rule.tcp.*.id, count.index)}"]
  }
}

resource "azurerm_network_interface_nat_rule_association" "windows-tutor-nic" {
  # network_interface_id  = "${azurerm_network_interface.windows-tutor-nic.id}"
  network_interface_id = "${element(azurerm_network_interface.windows-tutor-nic.*.id, count.index)}"
  # network_interface_id  = "${azurerm_network_interface.test.id}"
  ip_configuration_name = "ipconfig${count.index}"
  nat_rule_id           = "${element(azurerm_lb_nat_rule.tcp.*.id, count.index + 100)}"
  count                 = "${var.number_of_tutors}"
}
