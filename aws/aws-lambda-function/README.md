# AWS Lambda Application

Provisions an aws lambda function configured to write logs to cloudwatch.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.function_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.function_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.function_logging_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_envs"></a> [envs](#input\_envs) | Environment variables to be added to the lambda runtime | `any` | n/a | yes |
| <a name="input_execution_timeout"></a> [execution\_timeout](#input\_execution\_timeout) | Timeout period in seconds | `number` | `3` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name for the lambda function | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Docker image URI and tag | <pre>object({<br>    uri = string<br>    tag = string<br>  })</pre> | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Upper limit of memory in MB | `number` | `128` | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Retention time for execution logs in days | `number` | `7` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Role ARN to be used as the identity for the workload | `string` | n/a | yes |
| <a name="input_x_ray_enabled"></a> [x\_ray\_enabled](#input\_x\_ray\_enabled) | Enable AWS native tracing via X-Ray | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The amazon resource name of the function that was created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
