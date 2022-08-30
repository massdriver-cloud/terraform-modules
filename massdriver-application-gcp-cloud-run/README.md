# massdriver-application-gcp-cloud-run

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apis"></a> [apis](#module\_apis) | github.com/massdriver-cloud/terraform-modules//google-enable-apis | 9201b9f |
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | n/a |
| <a name="module_serverless_endpoint"></a> [serverless\_endpoint](#module\_serverless\_endpoint) | github.com/massdriver-cloud/terraform-modules//gcp-serverless-endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.public-access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>object({<br>    subdomain = string,<br>    zone      = string<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application"></a> [application](#output\_application) | The massdriver-application specification. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->