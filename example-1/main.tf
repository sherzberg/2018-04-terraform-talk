provider "github" {
  organization = "DevOpsDSM"
}

provider "mysql" {
  endpoint = "${var.mysql_endpoint}"
  username = "${var.mysql_username}"
  password = "${var.mysql_password}"
}

data "github_team" "devopsdsm" {
  slug = "super-awesome-team"
}

resource "mysql_database" "dev-database" {
  name = "development"
}

resource "mysql_user" "developer" {
  count              = "${length(data.github_team.devopsdsm.members)}"
  user               = "${element(data.github_team.devopsdsm.members, count.index)}"
  host               = "%"
  plaintext_password = "s3cr3t"
}

resource "digitalocean_droplet" "dev-box" {
  count = "${length(data.github_team.devopsdsm.members)}"
  name  = "${element(data.github_team.devopsdsm.members, count.index)}"

  image  = "ubuntu-16-04-x64"
  region = "nyc2"
  size   = "4096mb"
}

output "members" {
  value = "${data.github_team.devopsdsm.members}"
}
