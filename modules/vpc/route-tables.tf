#Create Public Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.env}-${var.app_name}-Public_Route_Table"
  }
}

#Associate the route table with the Public Subnet
resource "aws_route_table_association" "public_subnet_rt_ass" {
  subnet_id      = aws_subnet.app_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#Create Private Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.env}-${var.app_name}-Private_Route_Table"
  }
}

#Associate the route table with the Public Subnet
resource "aws_route_table_association" "private_subnet_rt_ass" {
  subnet_id      = aws_subnet.app_private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}