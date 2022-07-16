#Create Public Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.app_name}-${var.env}-Public_Route_Table"
  }
}

#Associate the route table with the Public Subnet
resource "aws_route_table_association" "public_subnet_rt_ass" {
  count          = length(var.az_list)
  subnet_id      = aws_subnet.app_public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#Create Private Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  count  = length(var.az_list)
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.app_name}-${var.env}-Private_Route_Table-${count.index + 1}"
  }
}

#Associate the route table with the Public Subnet
resource "aws_route_table_association" "private_subnet_rt_ass" {
  count          = length(var.az_list)
  subnet_id      = aws_subnet.app_private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}