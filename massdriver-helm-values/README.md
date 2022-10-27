# massdriver-helm-values

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | github.com/massdriver-cloud/terraform-modules//massdriver-application | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_common_labels"></a> [common\_labels](#output\_common\_labels) | n/a |
| <a name="output_envs"></a> [envs](#output\_envs) | n/a |
| <a name="output_k8s_service_account"></a> [k8s\_service\_account](#output\_k8s\_service\_account) | n/a |
| <a name="output_md_deployment_id"></a> [md\_deployment\_id](#output\_md\_deployment\_id) | n/a |
| <a name="output_mdx_application"></a> [mdx\_application](#output\_mdx\_application) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
