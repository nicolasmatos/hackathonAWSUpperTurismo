variable "owner" {}
variable "aws_region" {}
variable "project_name" {}
variable "db_group_private" {}
variable "sg_rds" {}
variable "tags" {}

variable "db_instance_type" {
  type        = string
  description = "Database Instance Type"
  default     = "db.t3.small"
}

variable "db_port" {
  type        = number
  description = "Database Port"
  default     = 1433
}

variable "db_name" {
  type        = string
  description = "Database Name"
  default     = "hackathon"
}

variable "db_user" {
  type        = string
  description = "Database User"
  default     = "root"
}
