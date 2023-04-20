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
| <a name="module_ec2"></a> [ec2](#module\ec2) | ./modules/ec2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami_from_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance) | resource |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [time_sleep](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

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

## Modules Inputs

| Name | Module | Type | Required |
|------|------|---------|:--------:|
| <a name="public_subnets"></a> public_subnets | [module.network](../network/output.tf) | `output` | yes |
| <a name="sg_ec2"></a> sg_ec2 |[module.network](../network/output.tf) | `output` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="ec2_id"></a> ec2_id | Instance ID |
| <a name="ec2_instance_type"></a> ec2_instance_type | Instance Type |
| <a name="ec2_monitoring"></a> ec2_monitoring | Instance Logs |
| <a name="key_name"></a> key_name | Key Pair Name |
| <a name="iam_instance_profile"></a> iam_instance_profile | IAM Profile |
