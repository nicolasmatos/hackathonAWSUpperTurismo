output "ec2_id" {
  value = aws_instance.ec2.id
}

output "ec2_instance_type" {
  value = var.ec2_instance_type
}

output "ec2_monitoring" {
  value = var.monitoring
}

output "key_name" {
  value = var.key_name
}