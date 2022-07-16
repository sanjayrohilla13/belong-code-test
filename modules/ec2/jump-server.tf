#Create Launch Configuration for Jump Server
resource "aws_launch_configuration" "jump_server_launch_conf" {
  name_prefix                 = "${var.app_name}-${var.env}-jump_server"
  image_id                    = data.aws_ami.instance_ami.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.public_security_group.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
}

#Create Auto Scaling Group for Jump Server
resource "aws_autoscaling_group" "jump_server_asg" {
  name                 = "${var.app_name}-${var.env}-jump_server_ASG"
  launch_configuration = aws_launch_configuration.jump_server_launch_conf.name
  #vpc_zone_identifier = ["${var.private_subnet_id}"]
  vpc_zone_identifier = [for subnet in var.public_subnet_ids : subnet]
  min_size            = 0
  max_size            = 2
  desired_capacity    = 1

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.env}-jump_server"
    propagate_at_launch = true
  }

}