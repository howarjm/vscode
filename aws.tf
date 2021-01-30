provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = "vpc-e6b4788f"

  ingress {
    description = "ssh from anywhere"
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

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "t2_micro" {
  count           = "2"
  ami             = "ami-0bdcc6c05dec346bf"
  instance_type   = "t2.micro"
  key_name        = "jhoward"
  security_groups = ["allow_ssh"]
  root_block_device {
    volume_size = 100
    encrypted   = true
  }

  tags = {
    name = "t2_micro"
  }
}
