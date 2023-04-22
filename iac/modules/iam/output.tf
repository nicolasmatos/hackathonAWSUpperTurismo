output "iam_instance_profile" {
  value = aws_iam_instance_profile.instance_profile_ec2.name
}

output "iam_user_access_id" {
  value = aws_iam_access_key.user_access_key.id
}

output "iam_user_access_secret" {
  value = aws_iam_access_key.user_access_key.secret
}

output "iam_role_ecs" {
  value = aws_iam_role.role_ecs.arn
}
