# massdriver-application-gcp-cloud-run

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.62.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apis"></a> [apis](#module\_apis) | github.com/massdriver-cloud/terraform-modules//gcp-enable-apis | 735929b |
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | 735929b |
| <a name="module_serverless_endpoint"></a> [serverless\_endpoint](#module\_serverless\_endpoint) | github.com/massdriver-cloud/terraform-modules//gcp-serverless-endpoint | c00db94 |

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service) | resource |
| [google_cloud_run_service_iam_member.public-access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container"></a> [container](#input\_container) | n/a | <pre>object({<br>    image = object({<br>      repository = string<br>      name       = string<br>      tag        = string<br>    })<br>    port        = number<br>    concurrency = number<br>  })</pre> | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata which is provided by the Massdriver deployment runtime | `any` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | n/a | <pre>object({<br>    location      = string<br>    max_instances = number<br>  })</pre> | n/a | yes |
| <a name="input_vpc_connector"></a> [vpc\_connector](#input\_vpc\_connector) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The massdriver-application specification. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
