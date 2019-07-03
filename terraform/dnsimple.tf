# Configure the DNSimple provider
provider "dnsimple" {
  token   = "${var.dnsimple_token}"
  account = "${var.dnsimple_account}"
}

# Add a record to a sub-domain
resource "dnsimple_record" "workstationlb" {
  domain = "test-rig.net"
  name   = "workstations.${var.lb_ip_dns_name}"
  value  = "${var.lb_ip_dns_name}.westeurope.cloudapp.azure.com"
  type   = "CNAME"
  ttl    = 60
}

resource "dnsimple_record" "jenkins" {
  domain = "test-rig.net"
  name   = "jenkins.${var.lb_ip_dns_name}"
  value  = "${azurerm_network_interface.jenkins-nic.private_ip_address}"
  type   = "A"
  ttl    = 60
}

resource "dnsimple_record" "app" {
  domain = "test-rig.net"
  name   = "app.${var.lb_ip_dns_name}"
  value  = "${azurerm_network_interface.app_host-nic.private_ip_address}"
  type   = "A"
  ttl    = 60
}

resource "dnsimple_record" "build" {
  domain = "test-rig.net"
  name   = "build.${var.lb_ip_dns_name}"
  value  = "${azurerm_network_interface.build_host-nic.private_ip_address}"
  type   = "A"
  ttl    = 60
}

#resource "dnsimple_record" "tutor" {
#  domain = "test-rig.net"
#  name   = "tutor.${var.lb_ip_dns_name}"
#  value  = "${azurerm_network_interface.windows-tutor-nic.private_ip_address}"
#  type   = "A"
#  ttl    = 60
#}

