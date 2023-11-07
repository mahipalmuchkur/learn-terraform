module "test" {
  source = "./local-module"
  instance_type = var.instance_type
}

variable "instance_type" {
  default = "t3.small"
}

output "test" {
  value = "module.test"
}