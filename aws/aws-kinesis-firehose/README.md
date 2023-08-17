# aws-kinesis-firehose

Creates a Kinesis Firehose with an assume role to write data to supported AWS Services. Currently only supports s3. This can be extended by adding downstream targets to the destinations block and making the configuration dynamic.

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
| [aws_iam_policy_attachment.firehose_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kinesis_firehose_delivery_stream.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_iam_policy_document.firehose_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_arn"></a> [bucket\_arn](#input\_bucket\_arn) | ARN of the destination bucket for Firehose to deliver to | `string` | n/a | yes |
| <a name="input_buffer_interval_seconds"></a> [buffer\_interval\_seconds](#input\_buffer\_interval\_seconds) | Amount of time in seconds in which to send data to the destination if the buffer size has not been fulfilled | `number` | `300` | no |
| <a name="input_buffer_size_mb"></a> [buffer\_size\_mb](#input\_buffer\_size\_mb) | Batch size in MB to send data to the destination | `number` | `64` | no |
| <a name="input_destination"></a> [destination](#input\_destination) | Service to send data to from Firehose | `string` | n/a | yes |
| <a name="input_dynamic_partitioning_enabled"></a> [dynamic\_partitioning\_enabled](#input\_dynamic\_partitioning\_enabled) | Enable s3 partitioning to group events in to unique keys in s3 based on a JQ query | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Firehose | `string` | n/a | yes |
| <a name="input_query"></a> [query](#input\_query) | JQ query which can extract a partition key from events | `string` | n/a | yes |
| <a name="input_write_policy_arn"></a> [write\_policy\_arn](#input\_write\_policy\_arn) | ARN of the write policy for the bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon resource ID of the firehose |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The arn of the role assumed by firehose |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the role assumed by firehose |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
