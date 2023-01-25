output "id" {
  value = module.application.id
}

output "cloud_init_rendered" {
  value = local.cloud_init_rendered
}
