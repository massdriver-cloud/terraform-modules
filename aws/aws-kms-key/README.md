# aws-kms-key

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
| [aws_kms_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_alias_context"></a> [key\_alias\_context](#input\_key\_alias\_context) | (Optional) Additional string context to append to the end of the key alias. This is useful in bundles where multiple keys are created and you need to give context to differentiate each key. Must be lowercase letters and hyphens without spaces and no more than 20. If this field is not empty, it will be appended to the end of the alias with a hyphen | `string` | `""` | no |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver package metadata object | `any` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | IAM policy to apply to the KMS key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | n/a |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
