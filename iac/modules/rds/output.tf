output "rds_id" {
  value = aws_db_instance.rds.id
}

output "rds_address" {
  value = aws_db_instance.rds.address
}

output "rds_db_name" {
  value = var.db_name
}

output "rds_port" {
  value = aws_db_instance.rds.port
}

output "rds_user" {
  value = aws_db_instance.rds.username
}

output "rds_password" {
  value = random_password.password.result
}
