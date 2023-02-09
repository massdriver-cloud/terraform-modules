# massdriver-application-gcp-vm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.52.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_channel"></a> [alarm\_channel](#module\_alarm\_channel) | github.com/massdriver-cloud/terraform-modules//gcp-alarm-channel | bfcf556 |
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | fc5f7b1 |
| <a name="module_cpu_alarm"></a> [cpu\_alarm](#module\_cpu\_alarm) | github.com/massdriver-cloud/terraform-modules//gcp-monitoring-utilization-threshold | cafdc89 |
| <a name="module_endpoint"></a> [endpoint](#module\_endpoint) | github.com/massdriver-cloud/terraform-modules//gcp-endpoint | 076ecd7 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_autoscaler.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_autoscaler) | resource |
| [google-beta_google_compute_instance_group_manager.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_instance_group_manager) | resource |
| [google-beta_google_compute_instance_template.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_instance_template) | resource |
| [google-beta_google_compute_target_pool.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_target_pool) | resource |
| [google_compute_firewall.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_health_check.autohealing](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_project_iam_member.containers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google-beta_google_compute_image.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_compute_image) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>object({<br>    port = number<br>    path = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | n/a | yes |
| <a name="input_max_instances"></a> [max\_instances](#input\_max\_instances) | n/a | `number` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | Massdriver metadata which is provided by the Massdriver deployment runtime | `any` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | n/a | yes |
| <a name="input_spot_instances_enabled"></a> [spot\_instances\_enabled](#input\_spot\_instances\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application"></a> [application](#output\_application) | The massdriver-application specification. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
