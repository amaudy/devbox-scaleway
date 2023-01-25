data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "scaleway_instance_security_group" "allow_all" {
}

resource "scaleway_instance_security_group" "devbox" {
  name                   = "scaleway-devbox"
  inbound_default_policy = "drop" # By default we drop incoming traffic that do not match any inbound_rule

  inbound_rule {
    action   = "accept"
    port     = 22
    ip_range = "${chomp(data.http.myip.body)}/32"
  }

  inbound_rule {
    action = "accept"
    port   = 80
  }

  inbound_rule {
    action = "accept"
    port   = 443
  }

  inbound_rule {
    action     = "accept"
    protocol   = "UDP"
    port_range = "22-23"
    ip_range   = "${chomp(data.http.myip.body)}/32"
  }

  outbound_rule {
    action   = "accept"
    ip_range = "0.0.0.0/0"
  }
}