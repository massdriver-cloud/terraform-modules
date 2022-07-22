output "key_arn" {
  value = local.create_key ? aws_kms_key.main.0.arn : null
}

output "alias_name" {
  value = local.create_key ? aws_kms_alias.main.0.name : null
}
