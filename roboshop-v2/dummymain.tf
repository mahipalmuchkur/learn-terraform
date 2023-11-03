variable "ami" {
  default = "ami-03265a0778a880afb"
}

variable "instance_type" {
  default = "t3.small"
}

variable "security_group" {
  default = [ "sg-08a14ab1911d86db6" ]
}

variable "zone_id" {
  default = "Z036242411JCZSVIGSVSH"
}
variable "components" {
  default = {
    frontend  = { name = "frontend-dev" }
    mongodb   = { name = "mongodb-dev" }
    catalogue = { name = "catalogue-dev" }
    redis     = { name = "redis-dev" }
    user      = { name = "user-dev" }
    cart      = { name = "cart-dev" }
    mysql     = {name = "mysql-dev" }
    shipping  = {name = "shipping-dev" }
    rabbitmq  = { name = "rabbitmq-dev" }
    payment   = { name = "payment-dev" }
    dispatch  = { name = "dispatch-dev" }
  }
}

resource "aws_instance" "instance" {
  for_each = var.components
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group

  tags = {
    Name = lookup(each.value, "name", null)
  }
}

resource "aws_route53_record" "record" {
  for_each = var.components
  zone_id = var.zone_id
  name    = "${lookup(each.value, "name", null)}.mdevopsb74.online"
  type    = "A"
  ttl     = "30"
  records    = [lookup(lookup(aws_instance.instance, each.key, null), "private_ip", null)]
}
#resource "aws_route53_record" "record" {
#  for_each = var.components
#  zone_id  = var.zone_id
#  name     = "${lookup(each.value, "name", null)}.mdevopsb74.online"
#  type     = "A"
#  ttl      = "30"
#  records  = [lookup(lookup(aws_instance.instance, each.key, null ), "private_ip", null)]
#}

#
#variable "ami" {
#  default = "ami-03265a0778a880afb"
#}
#
#variable "instance_type" {
#  default = "t3.small"
#}
#
#variable "security_groups" {
#  default = [ "sg-08a14ab1911d86db6" ]
#}
#
#variable "zone_id" {
#  default = "Z036242411JCZSVIGSVSH"
#}
#
#variable "components" {
#  default = {
#    frontend    = { name = "frontend" }
#    mongodb     = { name = "mongodb" }
#    catalogue   = { name = "catalogue" }
#    redis       = { name = "redis" }
#    user        = { name = "user" }
#    cart        = { name  = "cart" }
#    mysql       = { name = "mysql" }
#    shipping    = { name = "shipping" }
#    rabbitmq    = { name = "rabbitmq" }
#    payment     = { name = "payment" }
#  }
#}
#
#resource "aws_instance" "instance" {
#  for_each               = var.components
#  ami                    = var.ami
#  instance_type          = var.instance_type
#  vpc_security_group_ids = var.security_groups
#
#
#  tags = {
#    Name = lookup(each.value, "name", null )
#  }
#}
#
#resource "aws_route53_record" "record" {
#  for_each = var.components
#  zone_id  = var.zone_id
#  name     = "${lookup(each.value, "name", null )}.mdevopsb74.online"
#  type     = "A"
#  ttl      = "30"
#  records  = [lookup(lookup(aws_instance.instance, each.key, null ), "private_ip", null)]
#}
