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
| <a name="module_as"></a> [Auto Scaling](#module\as) | ./modules/as | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Locals Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="tags"></a> tags | `list` | `null` | yes |
| <a name="tags_asg"></a> tags_asg | `map` | `null` | yes |

## Variables Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="owner"></a> owner | `string` | `null` | yes |
| <a name="aws_region"></a> aws_region | `string` | `null` | yes |
| <a name="project_name"></a> project_name | `string` | `null` | yes |

## Modules Inputs

| Name | Module | Type | Required |
|------|------|---------|:--------:|
| <a name="public_subnets"></a> public_subnets | [module.network](../network/output.tf) | `output` | yes |
| <a name="alb_tg_id"></a> alb_tg_id | [module.alb](../alb/output.tf) | `output` | yes |
| <a name="key_name"></a> key_name | [module.ec2](../ec2/output.tf) | `output` | yes |
| <a name="ec2_instance_type"></a> ec2_instance_type | [module.ec2](../ec2/output.tf) | `output` | yes |
| <a name="ec2_monitoring"></a> ec2_monitoring | [module.ec2](../ec2/output.tf) | `output` | yes |
| <a name="iam_instance_profile"></a> iam_instance_profile | [module.ec2](../ec2/output.tf) | `output` | yes |
| <a name="sg_ec2"></a> sg_ec2 | [module.network](../network/output.tf) | `output` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="asg_id"></a> [asg_id](./output.tf) | Auto Scaling Group ID |
