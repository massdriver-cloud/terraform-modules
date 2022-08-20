# massdriver-application

This module configures an application to run on Massdriver provisioned infrastructure in a cloud agnostic way.

It creates an IAM Role or Service Account (depending on the cloud), gives permissions to the cloud services (lambda, ec2, k8s) to assume the role, and binds application level permissions from massdriver artifacts' security policies (SQS, S3, etc).

It also parses `policies` and `envs` from the _massdriver.yaml_ `app` field.

It provides a means to design applications in Massdriver to be cloud agnostic.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_jq"></a> [jq](#provider\_jq) | 0.2.0 |
| <a name="provider_mdxc"></a> [mdxc](#provider\_mdxc) | 0.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mdxc_application_identity.main](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/resources/application_identity) | resource |
| [mdxc_application_permission.main](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/resources/application_permission) | resource |
| [jq_query.envs](https://registry.terraform.io/providers/massdriver-cloud/jq/latest/docs/data-sources/query) | data source |
| [jq_query.policies](https://registry.terraform.io/providers/massdriver-cloud/jq/latest/docs/data-sources/query) | data source |
| [mdxc_cloud.current](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/data-sources/cloud) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity"></a> [identity](#input\_identity) | The identity this application wil assume. Assume Role Policy for IAM ... TODO | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the application. | `string` | n/a | yes |
| <a name="input_root_path"></a> [root\_path](#input\_root\_path) | Path to root module. This is used to load massdriver.yaml and params/connection variables. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud"></a> [cloud](#output\_cloud) | The cloud provisioning executed in. |
| <a name="output_envs"></a> [envs](#output\_envs) | The policies parsed from massdriver.yaml |
| <a name="output_policies"></a> [policies](#output\_policies) | The policies parsed from massdriver.yaml |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
