resource "aws_autoscaling_policy" "high_cpu_policy" {
  name                   = "${var.env}-${var.app_name}-high-cpu-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_auto_scaling_grp.name
}

resource "aws_cloudwatch_metric_alarm" "cw_high_cpu_metric_alarm" {
  alarm_name                = "${var.env}-${var.app_name}-high_cpu_metric_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors EC2 CPU utilization"
  
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_auto_scaling_grp.name
  }

  alarm_actions     = [aws_autoscaling_policy.high_cpu_policy.arn]
  # SNS policy to be added later
  insufficient_data_actions = []
}

resource "aws_autoscaling_policy" "low_cpu_policy" {
  name                   = "${var.env}-${var.app_name}-low-cpu-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_auto_scaling_grp.name
}

resource "aws_cloudwatch_metric_alarm" "cw_low_cpu_metric_alarm" {
  alarm_name                = "${var.env}-${var.app_name}-metric_alarm"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "5"
  alarm_description         = "This metric monitors EC2 CPU utilization"
  
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_auto_scaling_grp.name
  }

  alarm_actions     = [aws_autoscaling_policy.low_cpu_policy.arn]
  # SNS policy to be added later
  insufficient_data_actions = []
}