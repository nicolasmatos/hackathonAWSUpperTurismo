resource "aws_ecs_cluster" "fargate-cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster"
    }
  )
}
