# resource "aws_instance" "jump_server" {
#   # count = length(var.az_list)
#   count = 1
#   ami           = data.aws_ami.instance_ami.id
#   instance_type = var.instance_type
#   subnet_id = var.public_subnet_ids[count.index]
#   #security_groups = [ aws_security_group.public_security_group.id ]
#   vpc_security_group_ids = [ aws_security_group.public_security_group.id ]
#   associate_public_ip_address = true
#   key_name = var.key_name
#   tags = {
#     Name = "${var.env}-${var.app_name}-jump_server-${count.index+1}"
#   }
# }