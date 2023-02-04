resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_server" "devbox" {
  name  = "scaleway-devbox"
  type  = var.type
  image = var.image
  ip_id = scaleway_instance_ip.public_ip.id

  security_group_id = scaleway_instance_security_group.devbox.id

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Ready to continue"]

    connection {
      host  = self.public_ip
      type  = "ssh"
      user  = "root"
      agent = "true"
    }
  }

  provisioner "local-exec" {
    working_dir = "${path.cwd}/ansible"
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.public_ip},'  setup-devbox.yml"
  }
}

output "public_ip" {
  value = {
    "Your Development machine IP is:" = scaleway_instance_server.devbox.public_ip
  }
}