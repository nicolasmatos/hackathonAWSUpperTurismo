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

resource "aws_iam_user" "user" {
  name = "${var.project_name}-s3"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-s3"
    }
  )
}

resource "aws_iam_user_policy_attachment" "iam_police_attachment_user_s3" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_access_key" "user_access_key" {
  user       = aws_iam_user.user.name
  depends_on = [aws_iam_user.user]
}

resource "aws_iam_role" "role_ecs" {
  name = "${var.project_name}-ecs-task-assume-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "main" {
  name = "${var.project_name}-ecs-task"
  role = aws_iam_role.role_ecs.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "s3:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
