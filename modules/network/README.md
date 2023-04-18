## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.19 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.19 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_network_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |

## Locals Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="tags"></a> tags | `list` | `null` | yes |

## Variables Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="owner"></a> owner | `string` | `null` | yes |
| <a name="aws_region"></a> aws_region | `string` | `null` | yes |
| <a name="project_name"></a> project_name | `string` | `null` | yes |

## Variables

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="vpc_cidr"></a> vpc_cidr | `string` | `10.2.0.0/16` | yes |
| <a name="count_public_subnet"></a> count_public_subnet | `number` | `6` | yes |
| <a name="count_private_subnet"></a> count_private_subnet | `number` | `6` | yes |
| <a name="sg_ec2"></a> sg_ec2 | `list(number)` | `[22, 80, 443, 3000]` | yes |
| <a name="sg_alb"></a> sg_alb | `ist(number)` | `[80, 443]` | yes |
| <a name="sg_rds"></a> sg_rds | `ist(number)` | `[5432]` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="aws_region"></a> aws_region | Region Default AWS |
| <a name="project_name"></a> project_name | Name of Project |
| <a name="vpc_id"></a> vpc_id | VPC ID |
| <a name="public_subnets_id"></a> public_subnets_id | List of public subnets IDs |
| <a name="private_subnets_id"></a> private_subnets_id | List of private subnets IDs |
| <a name="sg_ec2_id"></a> sg_ec2_id | Security Group EC2 ID |
| <a name="sg_alb_id"></a> sg_alb_id | Security Group Load Balancer ID |
| <a name="sg_rds_id"></a> sg_rds_id | Security Group RDS ID |
| <a name="db_group_pub_id"></a> db_group_pub_id | Public Group RDS |
| <a name="db_group_priv_id"></a> db_group_priv_id | Private Group RDS |
