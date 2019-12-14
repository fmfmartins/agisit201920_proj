# Terraform AWS multi tier deployment

#Debugging
#OS_DEBUG=1
#TF_LOG=DEBUG

variable "access_key" {}
variable "secret_key" {}
variable "token" {}
variable "region"	{}
variable "ssh_key_public" {}
variable "ssh_key_private" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region
}

output "terraform-provider" {
    value = "Connected with AWS at region ${var.region}"
}
