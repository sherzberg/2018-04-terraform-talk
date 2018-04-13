resource "null_resource" "workspace" {
  count = "${var.instance_count}"

  triggers = {
    INSTANCES_IPS = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
  }

  connection {
    user     = "root"
    host     = "${element(digitalocean_droplet.devbox.*.ipv4_address, count.index)}"
    key_file = "id_rsa"
    timeout  = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get dist-upgrade --yes",
      "apt-get install nginx",
    ]
  }

}
