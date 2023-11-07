data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["617766776617"]
}


resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = ["sg-08a14ab1911d86db6"]
}

variable "instance_type" {}

output "ami" {
  value = "data.aws_ami.ami"
}