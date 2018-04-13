variable "instance_count" {
  default = 3
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  count = "${var.instance_count}"

  tags {
    Name  = "${uuid()}"
    Index = "${count.index}"
  }
}

output "instance_ips" {
  value = "${join(",", digitalocean_droplet.devbox.*.ipv4_address)}"
}
