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
| <a name="requirement_mdxc"></a> [mdxc](#requirement\_mdxc) | >= 0.10.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_jq"></a> [jq](#provider\_jq) | 0.2.1 |
| <a name="provider_mdxc"></a> [mdxc](#provider\_mdxc) | 0.10.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mdxc_application_identity.main](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/resources/application_identity) | resource |
| [mdxc_application_permission.main](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/resources/application_permission) | resource |
| [jq_query.policies](https://registry.terraform.io/providers/massdriver-cloud/jq/latest/docs/data-sources/query) | data source |
| [mdxc_cloud.current](https://registry.terraform.io/providers/massdriver-cloud/mdxc/latest/docs/data-sources/cloud) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes"></a> [kubernetes](#input\_kubernetes) | Kubernetes configuration for binding the application identity to k8s workload identity (GCP) or federated assume role (AWS). Required if service='kubernetes'. | <pre>object({<br>    # k8s namespace workload will run in<br>    namespace = string,<br>    # Massdriver connection artifact<br>    cluster_artifact = any<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure only, the location of the resource group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application. This should be the Massdriver package name. var.md\_metadata.name\_prefix | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure only, the name of resource group to create the Managed Identity in. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | The cloud service type that will run this workload. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud"></a> [cloud](#output\_cloud) | The cloud provisioning executed in. |
| <a name="output_connections"></a> [connections](#output\_connections) | Connections provided to bundle. |
| <a name="output_envs"></a> [envs](#output\_envs) | A key/value map of environment variables for the bundle. |
| <a name="output_envs_and_secrets"></a> [envs\_and\_secrets](#output\_envs\_and\_secrets) | A combined key/value map of both environment variables and secrets. This is usually used to set all the environment variables. |
| <a name="output_identity"></a> [identity](#output\_identity) | Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity, etc) |
| <a name="output_identity_block"></a> [identity\_block](#output\_identity\_block) | The full MDXC Cloud Identity object, for accessing additional values beyond the ID of the Identity. |
| <a name="output_params"></a> [params](#output\_params) | Parameters provided to bundle. |
| <a name="output_policies"></a> [policies](#output\_policies) | The policies parsed from massdriver.yaml |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | A key/value map of secrets for the bundle. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
