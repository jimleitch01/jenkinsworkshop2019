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

# workstations.test-rig.net	jws2019.jws2019
