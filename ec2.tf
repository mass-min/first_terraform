provider "aws" {
  profile = "default"
  region = "ap-northeast-1"
}

# セキュリティグループ
resource "aws_security_group" "terraform-web-sg" {
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags = {
    Name = "sg-terraform"
  }
}

# インバウンドのルール
resource "aws_security_group_rule" "inbound_http" {
  security_group_id = aws_security_group.terraform-web-sg.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}
resource "aws_security_group_rule" "inbound_ssh" {
  security_group_id = aws_security_group.terraform-web-sg.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

# EC2
resource "aws_instance" "terraform-web" {
  ami = "ami-0ab3e16f9c414dee7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform-web-sg.id] # <= 追加
  key_name = "test_terraform"
  tags = {
    Name = "ec2-terraform"
  }
  provisioner "remote-exec" {
    connection {
      host = self.public_dns
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/test_terraform.pem")
    }
    inline = [
      "sudo yum -y update && sudo yum install -y nginx && sudo service nginx start"
    ]
  }
}
