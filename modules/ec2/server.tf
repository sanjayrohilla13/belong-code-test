#Create Launch Configuration
resource "aws_launch_configuration" "app_launch_conf" {
  name_prefix   = "${var.env}-${var.app_name}"
  image_id      = data.aws_ami.instance_ami.id
  instance_type = var.instance_type
  security_groups = [ aws_security_group.private_security_group.id ]
  key_name = var.key_name
  iam_instance_profile = var.app_instance_profile
  #user_data = "${path.module}/scripts/user-data.sh"
  user_data = templatefile("${path.module}/user-script/user-data.sh", { timezone = var.time_zone })

  lifecycle {
    create_before_destroy = true
  }

}

#Create Auto Scaling Group
resource "aws_autoscaling_group" "app_auto_scaling_grp" {
  name                 = "${var.env}-${var.app_name}-ASG"
  launch_configuration = aws_launch_configuration.app_launch_conf.name
  #vpc_zone_identifier = ["${var.private_subnet_id}"]
  vpc_zone_identifier = [for subnet in var.private_subnet_ids : subnet]
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  target_group_arns = [aws_lb_target_group.app_target_group.arn]
  
  tag {
    key = "Name"
    value = "${var.env}-${var.app_name}-web-server"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}