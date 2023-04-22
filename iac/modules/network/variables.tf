variable "owner" {}
variable "aws_region" {}
variable "project_name" {}
variable "tags" {}

variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "count_public_subnet" {
  type        = number
  description = "Number of public subnets to be created"
  default     = 6
}

variable "count_private_subnet" {
  type        = number
  description = "Number of private subnets to be created"
  default     = 6
}

variable "sg_ec2" {
  type        = list(number)
  description = "Ports for the SG EC2"
  default     = [22, 80, 443]
}

variable "sg_alb" {
  type        = list(number)
  description = "Ports for the SG Load Balance"
  default     = [80, 443]
}

variable "sg_rds" {
  type        = list(number)
  description = "Ports for the SG RDS"
  default     = [1433]
}

variable "sg_ecs" {
  type        = list(number)
  description = "Ports for the SG ECS"
  default     = [80, 443]
}