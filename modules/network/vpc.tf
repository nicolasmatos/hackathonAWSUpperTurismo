resource "aws_vpc" "vpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true

  cidr_block = var.vpc_cidr
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}"
    }
  )
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "ig-${var.project_name}"
    }
  )
}

resource "aws_subnet" "public_subnets" {
  count                   = var.count_public_subnet
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public${count.index + 1}"
    }
  )
}

resource "aws_subnet" "private_subnets" {
  count                   = var.count_private_subnet
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 100)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private${count.index + 1}"
    }
  )
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = merge(
    var.tags,
    {
      Name = "rt-${var.project_name}-public"
    }
  )
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.tags,
    {
      Name = "rt-${var.project_name}-private"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = var.count_public_subnet
  route_table_id = aws_route_table.rt_public.id
  subnet_id      = aws_subnet.public_subnets.*.id[count.index]
}

resource "aws_route_table_association" "private" {
  count          = var.count_private_subnet
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = aws_subnet.private_subnets.*.id[count.index]
}

resource "aws_db_subnet_group" "db_group_public" {
  name       = "${var.project_name}-public"
  subnet_ids = [for subnet in aws_subnet.public_subnets : subnet.id]
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public"
    }
  )
}

resource "aws_db_subnet_group" "db_group_private" {
  name       = "${var.project_name}-private"
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private"
    }
  )
}
