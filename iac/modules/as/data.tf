data "aws_ami" "api" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.project_name}-app"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.owner}"]
}
