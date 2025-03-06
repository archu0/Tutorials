provider "aws" {
region = "ap-south-1"
}
resource "aws_instance" "terraform_master" {
  ami                         = "ami-0f2ce9ce760bd7133"
  instance_type               = "t2.micro"
  key_name                    = "archana_09"
  tags = {
    Name = "masterterraform"
  }
  security_groups= [aws_security_group.sg1.name]
  user_data =file("sample1.sh")
}

resource "aws_instance" "terraform_worker" {
  ami                         = "ami-0f2ce9ce760bd7133"
  instance_type               = "t2.micro"
  key_name                    = "archana_09"
  tags = {
    Name = "workerterraform"
  }
  security_groups= [aws_security_group.sg1.name]
  user_data =file("sample1.sh")
}
resource "aws_security_group" "sg1" {
  tags = {
    Name = "securitygroup"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "private_ip1" {
    value = aws_instance.terraform_master.private_ip
}
output "private_ip2" {
    value = aws_instance.terraform_worker.private_ip
}
output "public_ip" {
    value = aws_instance.terraform_master.public_ip
}
