resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group

  tags = {
    Name = var.name
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = var.zone_id
  name    = "${var.name}-dev.mdevopsb74.online"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.instance.private_ip]
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = <<EOF
cd /home/centos/learn-ansible
git pull
sleep 30
ansible-palybook -i ${var.name}-dev.mdevopsb74.online, main.yml -e ansible_user=centos -e ansible_password=DevOps321 -e component=${var.name}
    EOF
  }
}