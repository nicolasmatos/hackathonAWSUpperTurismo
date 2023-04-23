resource "aws_security_group" "sg_ec2" {
  name        = "sg_${var.project_name}_ec2"
  description = "Security Group for EC2"
  vpc_id      = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "sg_${var.project_name}_ec2"
    }
  )

  // utilizacao de blocos dinamicos para liberacao de portas no SG
  dynamic "ingress" {
    for_each = var.sg_ec2
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs" {
  name        = "sg_${var.project_name}_ecs"
  description = "Security Group for ECS"
  vpc_id      = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "sg_${var.project_name}_ec2"
    }
  )

  // utilizacao de blocos dinamicos para liberacao de portas no SG
  dynamic "ingress" {
    for_each = var.sg_ecs
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_alb" {
  name        = "sg_${var.project_name}_alb"
  description = "Security Group for ALB"
  vpc_id      = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "sg_${var.project_name}_alb"
    }
  )

  dynamic "ingress" {
    for_each = var.sg_alb
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_rds" {
  name        = "sg_${var.project_name}_rds"
  description = "Security Group for RDS"
  vpc_id      = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "sg_${var.project_name}_rds"
    }
  )

  dynamic "ingress" {
    for_each = var.sg_rds
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.sg_ec2.id, aws_security_group.sg_ecs.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
