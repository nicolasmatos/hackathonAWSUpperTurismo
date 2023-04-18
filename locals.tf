locals {
  tags = {
    owner       = var.owner
    project     = var.project_name
    terraform   = var.terraform
    environment = var.environment
  }
  tags_asg = [
    {
      key                 = "Name"
      value               = "${var.project_name}-api"
      propagate_at_launch = true
    },
    {
      key                 = "owner"
      value               = var.owner
      propagate_at_launch = true
    },
    {
      key                 = "project"
      value               = var.project_name
      propagate_at_launch = true
    },
    {
      key                 = "terraform"
      value               = var.terraform
      propagate_at_launch = true
    },
    {
      key                 = "environment"
      value               = var.environment
      propagate_at_launch = true
    }
  ]
}
