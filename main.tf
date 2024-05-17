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

resource "aws_instance" "blog" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = ["sg-046f0acca3658f6fc"]
  # id        = aws_vpc.learn-vpc.id
  subnet_id     = "subnet-02ca2edd2921b5488"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "blog"{
  name  = "blog"
  description = "Allow http and https in."
  # vpc_id 
}

resource "aws_security_group_rule" "blog_http_in"{
  type              = "ingress"
  from_port         = 80 
  to_port           = 80 
  protocol          = "tcp" 
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id
}

