# aws-eventbridge-rule

Creates an Eventbridge rule with an IAM role to assume and target configuration for sending events to downstream services.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.eventbridge_rule_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.eventbridge_assume_role_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_bus_arn"></a> [event\_bus\_arn](#input\_event\_bus\_arn) | The ARN of the event bus to attach the rule to | `string` | n/a | yes |
| <a name="input_event_filter"></a> [event\_filter](#input\_event\_filter) | Determines whether to send all events or a subset to the target | `string` | n/a | yes |
| <a name="input_event_filter_pattern"></a> [event\_filter\_pattern](#input\_event\_filter\_pattern) | Filter pattern to use in choosing which events to send | `string` | `"{}"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Eventbridge Rule | `string` | n/a | yes |
| <a name="input_target_resource_arn"></a> [target\_resource\_arn](#input\_target\_resource\_arn) | The ARN of the event rule target | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the event rule |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the role assumed by the event rule |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the role assumed by the event rule |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
