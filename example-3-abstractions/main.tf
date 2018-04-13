module "my-infra" {
  source = "./my-modules/infra"

  static_ips    = ["10.0.0.1", "10.0.0.2"]
  default_image = "ubuntu-14-04-x64"

  root_domain = "herzbergenterprises.com"
}

module "my-cheap-yuckie-service" {
  source = "./my-modules/service"

  cluster = "${module.my-infra.cluster}"

  name        = "my-yuckie"
  root_domain = "${module.my-infra.root_domain}"
  image       = "${module.my-infra.image}"
}

module "my-scalable-pci-service" {
  source = "./my-modules/pci-service"

  ssl_certificate = "${module.my-infra.wildcard_cert}"
  cluster         = "${module.my-infra.cluster}"
  backend_count   = 2

  name        = "my-service"
  root_domain = "${module.my-infra.root_domain}"
  image       = "${module.my-infra.image}"
}
