# k8s-external-dns-azure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.27.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.19.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-dns"></a> [external-dns](#module\_external-dns) | ../k8s-external-dns | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.external_dns](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_role_assignment.external_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [kubernetes_secret.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_dns_zones"></a> [azure\_dns\_zones](#input\_azure\_dns\_zones) | n/a | <pre>object({<br>    dns_zones      = set(string)<br>    resource_group = string<br>  })</pre> | <pre>{<br>  "dns_zones": [],<br>  "resource_group": ""<br>}</pre> | no |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | A kubernetes\_cluster artifact | `any` | n/a | yes |
| <a name="input_md_metadata"></a> [md\_metadata](#input\_md\_metadata) | md\_metadata object | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `string` | n/a | yes |
| <a name="input_release"></a> [release](#input\_release) | Release name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
