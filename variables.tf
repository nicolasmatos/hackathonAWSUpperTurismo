variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "owner" {
  type        = string
  description = ""
  default     = "432627114264"
}

variable "project_name" {
  type        = string
  description = ""
  default     = "hackathon-upper-turismo"
}

variable "domain_name" {
  type        = string
  description = ""
  default     = "upperturismo.com.br"
}

variable "terraform" {
  type        = bool
  description = ""
  default     = true
}

variable "environment" {
  type        = string
  description = ""
  default     = "dev"
}
