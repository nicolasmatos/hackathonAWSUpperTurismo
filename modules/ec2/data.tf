data "template_file" "script" {
  template = file("./modules/ec2/userdata.sh")
  vars = {
    aws_region = var.aws_region
  }
}
