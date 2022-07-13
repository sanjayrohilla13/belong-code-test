#Create Launch Configuration
resource "aws_launch_configuration" "app_launch_conf" {
  name_prefix   = "${var.env}-${var.app_name}"
  image_id      = data.aws_ami.instance_ami.id
  instance_type = var.instance_type
  security_groups = [ aws_security_group.private_security_group.id ]
  key_name = var.key_name
  #user_data = "${path.module}/scripts/user-data.sh"
  user_data = templatefile("${path.module}/user-script/user-data.sh", { timezone = var.time_zone })

  lifecycle {
    create_before_destroy = true
  }

}

#Create Auto Scaling Group
resource "aws_autoscaling_group" "app_launch_conf" {
  name                 = "${var.env}-${var.app_name}-ASG"
  launch_configuration = aws_launch_configuration.app_launch_conf.name
  vpc_zone_identifier = ["${var.private_subnet_id}"]
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  
  tag {
    key = "Name"
    value = "${var.env}-${var.app_name}-web-server"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}