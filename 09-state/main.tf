terraform {
  backend "s3" {
    bucket = "tf-state-m74"
    key    = "09-state/terraform.tfstate"
    region = "us-east-1"
  }
}

variable "test" {
  default = 'Hello Terraform'
}

output "test" {
  value = "var.test"
}