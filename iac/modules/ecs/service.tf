resource "aws_ecs_service" "service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.fargate-cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnets
    security_groups  = var.sg_ecs
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer == true ? [1] : []
    content {
      container_name   = "${var.project_name}-container"
      container_port   = var.container_port
      target_group_arn = var.alb_tg_id
    }
  }
}