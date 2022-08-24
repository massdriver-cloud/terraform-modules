# massdriver-application-helm

Helm implementation of [`massdriver-application`](../massdriver-application).

This module deploys your helm chart in a cloud agnostic way.

## Example

*Deploying a kubernetes workload*:

```hcl
module "helm" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application-helm"
  name    = var.md_metadata.name_prefix
  namespace = var.namespace
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
