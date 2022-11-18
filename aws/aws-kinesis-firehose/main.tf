locals {
  destinations = {
    "s3" = "extended_s3"
  }

  default_key_prefix     = "data/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/!{timestamp:HH}/"
  partitioned_key_prefix = "data/!{partitionKeyFromQuery:partition_key}/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/!{timestamp:HH}/"

  key_prefix = var.dynamic_partitioning_enabled ? local.partitioned_key_prefix : local.default_key_prefix
  name       = "${var.name}-firehose"
}

resource "aws_kinesis_firehose_delivery_stream" "main" {
  name        = local.name
  destination = local.destinations[var.destination]

  dynamic "extended_s3_configuration" {
    for_each = var.dynamic_partitioning_enabled ? [1] : []
    content {
      role_arn            = aws_iam_role.firehose_role.arn
      bucket_arn          = var.bucket_arn
      prefix              = local.key_prefix
      error_output_prefix = "errors/!{timestamp:yyyy}/!{timestamp:MM}/!{timestamp:dd}/!{timestamp:HH}/!{firehose:error-output-type}/"
      buffer_size         = var.buffer_size     # In MB
      buffer_interval     = var.buffer_interval # In seconds

      dynamic_partitioning_configuration {
        enabled = true
      }

      processing_configuration {
        enabled = true

        processors {
          type = "MetadataExtraction"
          parameters {
            parameter_name  = "JsonParsingEngine"
            parameter_value = "JQ-1.6"
          }
          parameters {
            parameter_name  = "MetadataExtractionQuery"
            parameter_value = format("{partition_key:%s}", var.query)
          }
        }
      }
    }
  }
}

resource "aws_iam_role" "firehose_role" {
  name        = "firehose_test_role"
  description = "Assume role for ${local.name}"

  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role_policy.json
}

data "aws_iam_policy_document" "firehose_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "firehose_write_policy" {
  name       = "${local.name}-write-policy-attachment"
  roles      = [aws_iam_role.firehose_role.name]
  policy_arn = var.write_policy_arn
}
