resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.project_name}-container-log"
  retention_in_days = var.log_retention_days
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.project_name}-task"
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.iam_role_ecs
  task_role_arn            = var.iam_role_ecs
  container_definitions = jsonencode([{
    name      = "${var.project_name}-container"
    image     = var.container_image
    essential = true
    portMappings = [
      {
        containerPort = var.container_port
        hostPort      = var.container_port
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "${aws_cloudwatch_log_group.log_group.name}"
        awslogs-region        = "${var.aws_region}"
        awslogs-stream-prefix = "${var.project_name}-container"

      }
    }
  }])
}