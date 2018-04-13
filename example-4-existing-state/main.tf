data "terraform_remote_state" "infra" {
  backend = "s3"

  config {
    bucket = "terraform-state-prod"
    key    = "infra/terraform.tfstate"
    region = "us-east-1"
  }
}

output "infravpc" {
  value = "${data.terraform_remote_state.infra.vpcid}"
}

output "idsips" {
  value = "${data.terraform_remote_state.infra.idsips}"
}