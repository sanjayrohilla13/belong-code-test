# resource "aws_lb" "app_alb" {
#   name               = "${var.env}-application-ALB"
#   internal           = false
#   load_balancer_type = "application"
#   #security_groups    = [aws_security_group.lb_sg.id]
#   #subnets            = [for subnet in aws_subnet.public : subnet.id]
#   subnets            = [var.public_subnet_id]

#   enable_deletion_protection = true

# #   access_logs {
# #     bucket  = aws_s3_bucket.lb_logs.bucket
# #     prefix  = "test-lb"
# #     enabled = true
# #   }

#   tags = {
#     Environment = "${var.env}-${var.app_name}-LB"
#   }
# }