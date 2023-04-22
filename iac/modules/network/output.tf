output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnets_id" {
  value = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "sg_ec2_id" {
  value = aws_security_group.sg_ec2.id
}

output "sg_alb_id" {
  value = aws_security_group.sg_alb.id
}

output "sg_rds_id" {
  value = aws_security_group.sg_rds.id
}

output "sg_ecs_id" {
  value = aws_security_group.sg_ecs.id
}

output "db_group_private_id" {
  value = aws_db_subnet_group.db_group_private.id
}

output "db_group_public_id" {
  value = aws_db_subnet_group.db_group_public.id
}

output "aws_region" {
  value = var.aws_region
}

output "project_name" {
  value = var.project_name
}
