output "id" {
  value = aws_ecs_cluster.fargate-cluster.id
}

output "arn" {
  value = aws_ecs_task_definition.task.arn
}

output "container_port" {
  value = var.container_port
}
