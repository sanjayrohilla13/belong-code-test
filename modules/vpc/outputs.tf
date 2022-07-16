output "private_subnet_ids" {
  value = aws_subnet.app_private_subnet[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.app_public_subnet[*].id
}

output "app_vpc_id" {
  value = aws_vpc.app_vpc.id
}