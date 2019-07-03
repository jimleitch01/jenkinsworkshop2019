resource "azurerm_network_interface" "jenkins-nic" {
  name                = "jenkins-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = "${var.number_of_jenkins}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "jenkins" {
  name                             = "jenkins-${count.index}"
  location                         = "${var.location}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  vm_size                          = "Standard_D2s_v3"
  network_interface_ids            = ["${element(azurerm_network_interface.jenkins-nic.*.id, count.index, )}"]
  count                            = "${var.number_of_jenkins}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true




  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "jenkins-disk${count.index}"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }

  os_profile {
    computer_name  = "jenkins-${count.index}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys {
    #   key_data = "file(~/.ssh/id_rsa.pub)"
    #   path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    # }
  }
}

