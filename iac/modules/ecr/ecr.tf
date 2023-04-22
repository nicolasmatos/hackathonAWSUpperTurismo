resource "aws_ecr_repository" "image_repository" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}"
    }
  )
}