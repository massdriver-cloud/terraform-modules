# massdriver-application

This module configures an application's IAM for a specific service to run on Massdriver provisioned infrastructure in a cloud agnostic way.

It creates an IAM Role or Service Account (depending on the cloud), gives permissions to the cloud services (lambda, ec2, k8s) to assume the role, and binds application level permissions from massdriver artifacts' security policies (SQS, S3, etc).

It also parses `policies` and `envs` from the _massdriver.yaml_ `app` field.

It provides a means to design applications in Massdriver to be cloud agnostic.

It is intended to be used by application runtime modules like: [massdriver-application-helm](../massdriver-application-helm/)

## Example

*Deploying a kubernetes workload*:

```hcl
module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
		# Massdriver cluster artifact
    cluster_artifact = var.kubernetes_cluster
  }
}
```

*Deploying a serverless function*:

```hcl
module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "function"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_mdxc"></a> [mdxc](#requirement\_mdxc) | >= 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_jq"></a> [jq](#provider\_jq) | 0.2.1 |
| <a name="provider_mdxc"></a> [mdxc](#provider\_mdxc) | 0.1.0 |

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
| <a name="input_kubernetes"></a> [kubernetes](#input\_kubernetes) | Kubernetes configuration for binding the application identity to k8s workload identity (GCP) or federated assume role (AWS). Required if service='kubernetes'. | <pre>object({<br>    # k8s namespace workload will run in<br>    namespace = string,<br>    # Massdriver connection artifact<br>    cluster_artifact = any<br>    # Azure AKS cluster produces this URL, needed for Workload Identity<br>    oidc_issuer_url = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure only, the location of the resource group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application. This should be the Massdriver package name. var.md\_metadata.name\_prefix | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure only, the name of resource group to create the Managed Identity in. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | The cloud service type that will run this workload. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud"></a> [cloud](#output\_cloud) | The cloud provisioning executed in. |
| <a name="output_envs"></a> [envs](#output\_envs) | The environment (config & secrets) parsed from massdriver.yaml |
| <a name="output_id"></a> [id](#output\_id) | Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity, etc) |
| <a name="output_identity"></a> [identity](#output\_identity) | The full MDXC Cloud Identity object, for accessing additional values beyond the ID of the Identity. |
| <a name="output_params"></a> [params](#output\_params) | Parameters provided to bundle. |
| <a name="output_policies"></a> [policies](#output\_policies) | The policies parsed from massdriver.yaml |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
