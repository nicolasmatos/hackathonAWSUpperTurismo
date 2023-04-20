data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_iam_role" "role_ec2" {
  name = "${var.project_name}-ec2-assume-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "role_police_attachment_ec2_s3" {
  name       = "${var.project_name}-ec2-assume-role"
  roles      = [aws_iam_role.role_ec2.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_policy_attachment" "role_police_attachment_ec2_ecr" {
  name       = "${var.project_name}-ec2-assume-role"
  roles      = [aws_iam_role.role_ec2.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "instance_profile_ec2" {
  name = "${var.project_name}-ec2-assume-role"
  role = aws_iam_role.role_ec2.name
}

resource "aws_instance" "ec2" {
  instance_type               = var.ec2_instance_type
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = var.sg_ec2
  subnet_id                   = element("${var.public_subnets}", 1)
  user_data                   = data.template_file.script.rendered
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile_ec2.name
  associate_public_ip_address = true
  monitoring                  = var.monitoring
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-app"
    }
  )
}

resource "time_sleep" "wait_seconds" {
  depends_on      = [aws_instance.ec2]
  create_duration = "300s"
}

resource "aws_ami_from_instance" "ami" {
  name                    = "${var.project_name}-app"
  source_instance_id      = aws_instance.ec2.id
  snapshot_without_reboot = true
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-app"
    }
  )

  depends_on = [time_sleep.wait_seconds]
}

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