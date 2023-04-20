resource "aws_network_acl" "acl_public" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [for subnet in aws_subnet.public_subnets : subnet.id]
  tags = merge(
    var.tags,
    {
      Name = "acl-${var.project_name}-public"
    }
  )

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_network_acl" "acl_priv" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]
  tags = merge(
    var.tags,
    {
      Name = "acl-${var.project_name}-private"
    }
  )

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
