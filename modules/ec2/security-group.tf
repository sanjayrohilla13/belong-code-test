#Private Security Group
resource "aws_security_group" "private_security_group" {
  name        = "${var.env}-${var.app_name}-Private-SG"
  description = "Allow Traffic from Internal Network only"
  vpc_id      = var.app_vpc_id

ingress {
    description      = "Allow SSH from Inside Network"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.public_security_group.id]
  }
ingress {
    description      = "Allow HTTP from Inside Network"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.public_security_group.id]
  }
#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${var.app_name}-Private-SG"
  }
}

#Public Security Group
resource "aws_security_group" "public_security_group" {
  name        = "${var.env}-${var.app_name}-Public-SG"
  description = "Allow Traffic from Internet"
  vpc_id      = var.app_vpc_id

ingress {
    description      = "Allow SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP Port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${var.app_name}-Public-SG"
  }
}