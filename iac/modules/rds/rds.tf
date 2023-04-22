resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "#"
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 250
  storage_type           = "gp2"
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4236.7.v1"
  identifier             = "db-${var.project_name}"
  license_model          = "license-included"
  instance_class         = var.db_instance_type
  multi_az               = false
  username               = var.db_user
  password               = random_password.password.result
  port                   = var.db_port
  availability_zone      = data.aws_availability_zones.available.names[0]
  skip_final_snapshot    = true
  db_subnet_group_name   = var.db_group_private
  vpc_security_group_ids = var.sg_rds
  tags = merge(
    var.tags,
    {
      Name = "db-${var.project_name}"
    }
  )
}
