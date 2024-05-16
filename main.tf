data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_vpc" "learn-vpc" {
  id = "vpc-0d5c2eb825eb54628"
}

resource "aws_instance" "blog" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  # vpc_security_group_ids = ["sg-046f0acca3658f6fc"]
  id        = aws_vpc.learn-vpc.id
  subnet_id     = "subnet-02ca2edd2921b5488"

  tags = {
    Name = "HelloWorld"
  }
}
