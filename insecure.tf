provider "aws" {
  region = "us-west-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_vpc" "insecure_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "insecure_subnet" {
  vpc_id     = aws_vpc.insecure_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "insecure_sg" {
  vpc_id = aws_vpc.insecure_vpc.id

  egress {
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
}

resource "aws_instance" "insecure_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  subnet_id           = aws_subnet.insecure_subnet.id
  vpc_security_group_ids = [aws_security_group.insecure_sg.id]

  tags = {
    Name = "InsecureInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "admin:insecurepassword" | chpasswd
              EOF
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"

  tags = {
    Name        = "InsecureBucket"
    Environment = "Dev"
  }
}
