output "rds_id" {
  value = aws_db_instance.rds.id
}

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_name" {
  value = var.db_name
}
