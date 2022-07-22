
locals {
  create_key    = var.kms_encryption.type == "custom"
  alias_context = var.key_alias_context != "" ? "-${var.key_alias_context}" : ""
  alias         = "alias/${var.md_metadata.name_prefix}${local.alias_context}"
}

resource "aws_kms_key" "main" {
  count                              = local.create_key ? 1 : 0
  description                        = "${var.md_metadata.name_prefix} encryption key"
  key_usage                          = "ENCRYPT_DECRYPT"
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  policy                             = var.policy
  bypass_policy_lockout_safety_check = false
  deletion_window_in_days            = 30
  is_enabled                         = true
  enable_key_rotation                = true
  multi_region                       = false
}

resource "aws_kms_alias" "main" {
  count         = local.create_key ? 1 : 0
  name          = local.alias
  target_key_id = aws_kms_key.main.0.key_id
}
