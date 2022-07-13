# Creation of VPC for the application
resource "aws_vpc" "app_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.env}-${var.app_name}-VPC"
  }
}

# Creation of Subnets for the application
# Private Subnets 
resource "aws_subnet" "app_private_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = var.private_cidr_block
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "${var.env}-${var.app_name}-Private Subnet"
  }
}

#Public Subnets
resource "aws_subnet" "app_public_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = var.public_cidr_block
  availability_zone = var.az_list

  tags = {
    Name = "${var.env}-${var.app_name}-Public Subnet"
  }
}