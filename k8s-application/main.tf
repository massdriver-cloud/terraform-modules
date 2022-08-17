resource "mdxc_application_identity" "main" {
  name = local.params.md_metadata.name_prefix
}

resource "mdxc_application_permission" "main" {
  for_each                = local.merged_policies
  application_identity_id = (mdxc_application_identity.main).gcp_application_identity.service_account_email
  gcp_configuration = {
    role      = each.value.role
    condition = each.value.condition
  }
}

resource "helm_release" "application" {
  name             = local.params.md_metadata.name_prefix
  chart            = "${path.root}/../chart"
  namespace        = local.params.namespace
  create_namespace = true
  force_update     = true

  values = [
    fileexists("${path.module}/../chart/values.yaml") ? file("${path.module}/../chart/values.yaml") : "",
    yamlencode(local.params),
    yamlencode(merge(
      local.helm_additional_values,
      local.helm_additional_values_gcp
    ))
  ]
}
