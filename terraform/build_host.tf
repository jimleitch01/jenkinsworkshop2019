resource "azurerm_network_interface" "build_host-nic" {
  name                = "build_host-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "azurerm_resource_group.rg.name"
  count               = "${var.number_of_build_hosts}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "build-host" {
  name                             = "build-host-${count.index}"
  location                         = "${var.location}"
  resource_group_name              = "azurerm_resource_group.rg.name"
  vm_size                          = "${var.vm_size}"
  network_interface_ids            = ["${element(azurerm_network_interface.build_host-nic.*.id, count.index, )}"]
  count                            = "${var.number_of_build_hosts}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "build-host-disk${count.index}"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }

  os_profile {
    computer_name  = "build-host-${count.index}"
    admin_username = "var.admin_username"
    admin_password = "var.admin_password"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = "file(~/.ssh/id_rsa.pub)"
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }
}

