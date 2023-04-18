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
| <a name="module_alb"></a> [alb](#module\alb) | ./modules/alb | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_alb_target_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

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
| <a name="domain_name"></a> domain_name | `string` | `null` | yes |

## Modules Inputs

| Name | Module | Type | Required |
|------|------|---------|:--------:|
| <a name="vpc_id"></a> vpc_id | [module.network](../network/output.tf) | `output` | yes |
| <a name="public_subnets"></a> public_subnets | [module.network](../network/output.tf) | `output` | yes |
| <a name="sg_alb"></a> sg_alb | [module.network](../network/output.tf) | `output` | yes |
| <a name="ec2_id"></a> ec2_id | [module.ec2](../ec2/output.tf) | `output` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="alb_id"></a> [alb_id](./output.tf) | Load Balancer ID |
| <a name="alb_dns_name"></a> [alb_dns_name](./output.tf) | Load Balancer DNS |
| <a name="alb_tg_id"></a> [alb_tg_id](./output.tf) | Target Group ID |
