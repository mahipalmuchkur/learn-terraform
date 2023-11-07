variable "zone_id" {
  default = "Z036242411JCZSVIGSVSH"
}
variable "security_groups" {
  default = ["sg-08a14ab1911d86db6"]
}

#variable "name" {}
#variable "instance_type" {}
variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }

  }
}