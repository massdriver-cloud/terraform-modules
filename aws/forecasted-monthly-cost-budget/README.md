# AWS Budget Management Terraform Module

This Terraform module provides a simple and flexible way to manage AWS budgets, allowing users to monitor and control their AWS spending. It creates a budget that tracks the cost of your AWS resources and notifies you when your spending exceeds predefined thresholds.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | n/a | `number` | `500` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | n/a | `any` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | n/a | `string` | `null` | no |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | n/a | `list` | `[]` | no |
| <a name="input_subscriber_sns_topic_arns"></a> [subscriber\_sns\_topic\_arns](#input\_subscriber\_sns\_topic\_arns) | n/a | `list` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
