variable "owner" {}
variable "aws_region" {}
variable "project_name" {}
variable "alb_tg_id" {}
variable "container_image" {}
variable "iam_role_ecs" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "sg_ecs" {}
variable "tags" {}

variable "cpu" {
  type        = number
  description = "Task definition CPU"
  default     = 1024
}

variable "memory" {
  type        = number
  description = "Task deifnition memory"
  default     = 2048
}

variable "essential" {
  type        = bool
  description = "Container essential"
  default     = true
}

variable "container_port" {
  type        = number
  description = "Container Port"
  default     = 80
}

variable "log_retention_days" {
  type        = number
  description = "Log retention in days"
  default     = 7
}

variable "desired_count" {
  type        = string
  description = "ECS Service desired count"
  default     = 1
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign public ip"
  default     = true
}

variable "load_balancer" {
  description = "Loadbalancer"
  type        = bool
  default     = true
}
