resource "aws_s3_bucket" "app" {
  bucket = "${var.project_name}-app"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-app"
    }
  )
}