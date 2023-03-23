# kinesis-stream

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.manage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kinesis_stream.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_retention_hours"></a> [retention\_hours](#input\_retention\_hours) | n/a | `number` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | n/a | `number` | n/a | yes |
| <a name="input_shard_level_metrics"></a> [shard\_level\_metrics](#input\_shard\_level\_metrics) | n/a | `list(string)` | `[]` | no |
| <a name="input_stream_mode"></a> [stream\_mode](#input\_stream\_mode) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_manage_policy_arn"></a> [manage\_policy\_arn](#output\_manage\_policy\_arn) | Kinesis stream manage policy ARN |
| <a name="output_read_policy_arn"></a> [read\_policy\_arn](#output\_read\_policy\_arn) | Kinesis stream read policy ARN |
| <a name="output_stream_arn"></a> [stream\_arn](#output\_stream\_arn) | Kinesis stream ARN |
| <a name="output_write_policy_arn"></a> [write\_policy\_arn](#output\_write\_policy\_arn) | Kinesis stream write policy ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
