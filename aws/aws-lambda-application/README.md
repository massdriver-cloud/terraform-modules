# AWS Lambda Application

Provisions an aws lambda function configured to write logs to cloudwatch and assigned a workload identity for interaction with various aws services.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | n/a |

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
| <a name="input_execution_timeout"></a> [execution\_timeout](#input\_execution\_timeout) | Timeout period in seconds | `number` | `3` | no |
| <a name="input_image"></a> [image](#input\_image) | Docker image URI and tag | <pre>object({<br>    uri = string<br>    tag = string<br>  })</pre> | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata which is provided by the Massdriver deployment runtime | `any` | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Upper limit of memory in MB | `number` | `128` | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Retention time for execution logs in days | `number` | `7` | no |
| <a name="input_x_ray_enabled"></a> [x\_ray\_enabled](#input\_x\_ray\_enabled) | Enable AWS native tracing via X-Ray | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The amazon resource name of the function that was created |
| <a name="output_identity_arn"></a> [identity\_arn](#output\_identity\_arn) | ARN of the workload identity created for the lambda function |
| <a name="output_identity_name"></a> [identity\_name](#output\_identity\_name) | Name of the workload identity created for the lambda function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
