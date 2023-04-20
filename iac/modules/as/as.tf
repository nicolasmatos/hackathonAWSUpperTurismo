resource "aws_launch_template" "lt" {
  name_prefix   = "lt-"
  image_id      = data.aws_ami.api.id
  instance_type = var.ec2_instance_type
  user_data     = filebase64("./modules/as/userdata.sh")
  key_name      = var.key_name
  monitoring {
    enabled = var.ec2_monitoring
  }
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = var.sg_ec2
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "asg-${var.project_name}"
  min_size                  = 0
  desired_capacity          = 0
  max_size                  = 0
  force_delete              = true
  health_check_grace_period = 240
  health_check_type         = "ELB"
  target_group_arns         = [var.alb_tg_id]
  vpc_zone_identifier       = var.public_subnets

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  tags = var.tags_asg
}

resource "aws_autoscaling_policy" "policy_up" {
  name                   = "${var.project_name}_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name          = "${var.project_name}_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "Esta métrica monitora a utilização da CPU da instância do EC2"
  alarm_actions     = [aws_autoscaling_policy.policy_up.arn]
}

resource "aws_autoscaling_policy" "policy_down" {
  name                   = "${var.project_name}_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
  alarm_name          = "${var.project_name}_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "Esta métrica monitora a utilização da CPU da instância do EC2"
  alarm_actions     = [aws_autoscaling_policy.policy_down.arn]
}
