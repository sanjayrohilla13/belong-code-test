resource "aws_lb" "app_alb" {
  name               = "${var.app_name}-${var.env}-ALB"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets                    = [for subnet in var.public_subnet_ids : subnet]
  security_groups            = [aws_security_group.public_security_group.id]
  enable_deletion_protection = false
  tags = {
    Name = "${var.app_name}-${var.env}-ALB"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

resource "aws_lb_target_group" "app_target_group" {
  name        = "${var.app_name}-${var.env}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.app_vpc_id
  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}