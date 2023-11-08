variable "zone_id" {
  default = "Z036242411JCZSVIGSVSH"
}
variable "security_group" {
  default = ["sg-08a14ab1911d86db6"]
}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.micro"
    }
  }
}