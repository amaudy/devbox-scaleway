resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_server" "devbox" {
  name  = "scaleway-devbox"
  type  = var.type
  image = var.image
  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.devbox.id
}

output "public_ip" {
  value = {
    "Your Development machine IP is:" = scaleway_instance_server.devbox.public_ip
  }
}