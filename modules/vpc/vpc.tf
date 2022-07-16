# Creation of VPC for the application
resource "aws_vpc" "app_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = "${var.app_name}-${var.env}-VPC"
  }
}

# Creation of Subnets for the application
# Private Subnets 
resource "aws_subnet" "app_private_subnet" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = var.az_list[count.index]

  tags = {
    Name = "${var.app_name}-${var.env}-Private_Subnet-${count.index + 1}"
  }
}

#Public Subnets
resource "aws_subnet" "app_public_subnet" {
  count             = length(var.public_cidr_blocks)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.public_cidr_blocks[count.index]
  availability_zone = var.az_list[count.index]

  tags = {
    Name = "${var.app_name}-${var.env}-Public_Subnet-${count.index + 1}"
  }
}