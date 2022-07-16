#Internet Gateway for Public Subnet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.app_name}-${var.env}-Internet_Gateway"
  }
}

#Create EIP for NAT Gateway
resource "aws_eip" "eip" {
  count = length(var.az_list)
  tags = {
    Name = "${var.app_name}-${var.env}-EIP-${count.index + 1}"
  }
}

#NAT Gateway for Private Subnets
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.az_list)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.app_public_subnet[count.index].id

  tags = {
    Name = "${var.app_name}-${var.env}-NAT_GW-${count.index + 1}"
  }

  #NAT Gatway should be created only if the NAT Gateway is created successfully
  depends_on = [aws_internet_gateway.internet_gateway]
}