# S3 Endpoint creation
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.app_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"

  tags = {
    Name = "${var.env}-${var.app_name}-s3_endpoint"
  }
}

#Association of the S3 End point with Private Route Table
resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint_rt_association" {
  count = length(var.az_list)
  route_table_id  = aws_route_table.private_route_table[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}