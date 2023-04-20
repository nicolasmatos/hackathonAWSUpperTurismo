variable "owner" {}
variable "aws_region" {}
variable "project_name" {}
variable "public_subnets" {}
variable "sg_ec2" {}
variable "tags" {}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have verbose monitoring enabled"
  type        = bool
  default     = true
}

variable "key_name" {
  type        = string
  description = "Access Key Pair"
  default     = "hackathon-upper-turismo"
}
