resource "digitalocean_tag" "foobar" {
  name = "foobar"
}

output "tags" {
 value = ["${digitalocean_tag.foobar.name}"]
}
