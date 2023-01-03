# cloudwatch-alarm-expression

A module for creating a Massdriver-integrated AWS alarm using complex metric expressions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |
| <a name="provider_massdriver"></a> [massdriver](#provider\_massdriver) | 1.1.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [massdriver_package_alarm.package_alarm](https://registry.terraform.io/providers/massdriver-cloud/massdriver/latest/docs/resources/package_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_name"></a> [alarm\_name](#input\_alarm\_name) | The descriptive name for the alarm. This name must be unique within the user's AWS account | `string` | n/a | yes |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and Threshold. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Short name to display in the massdriver UI. | `string` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold. | `string` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver Variables | `any` | n/a | yes |
| <a name="input_message"></a> [message](#input\_message) | n/a | `string` | n/a | yes |
| <a name="input_metric_queries"></a> [metric\_queries](#input\_metric\_queries) | Map of id to metric\_query object. See the [`aws_cloudwatch_metric_alarm`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) documentation for object structure | <pre>map(object({<br>    expression  = optional(string)<br>    label       = optional(string)<br>    return_data = optional(string)<br>    metric = optional(object({<br>      metric_name = string<br>      namespace   = string<br>      period      = string<br>      stat        = string<br>      unit        = optional(string)<br>      dimensions  = optional(map(string))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | Massdriver Alarm Channel - SNS Topic ARN | `string` | n/a | yes |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The value against which the specified statistic is compared. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
