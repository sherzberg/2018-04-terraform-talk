variable "dns_zone" {}

resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = "${file("./id_rsa.pub")}"
}

module "demo" {
  source = "git@github.com:sherzberg/terraform-again-talk.git//super-awesome-demo/do-webserver?ref=release-10"

  package             = "myapp-10"

  ssh_key_fingerprint = "${digitalocean_ssh_key.default.fingerprint}"
  dns_zone            = "${var.dns_zone}"
}

module "production" {
  source = "git@github.com:sherzberg/terraform-again-talk.git//super-awesome-demo/do-webserver?ref=release-9"

  package             = "myapp-9"

  ssh_key_fingerprint = "${digitalocean_ssh_key.default.fingerprint}"
  dns_zone            = "${var.dns_zone}"
}
