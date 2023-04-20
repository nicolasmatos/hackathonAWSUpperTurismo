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
| <a name="module_rds"></a> [rds](#module\rds) | ./modules/rds | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

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
| <a name="db_group_private"></a> db_group_private | [module.network](../network/output.tf) | `output` | yes |
| <a name="sg_rds"></a> sg_rds | [module.network](../network/output.tf) | `output` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="rds_id"></a> rds_id | RDS ID |
| <a name="rds_endpoint"></a> rds_endpoint | RDS Endpoint Access |
| <a name="db_name"></a> db_name | Database Name |
