locals {
  is_provisioned_mode = var.stream_mode == "PROVISIONED"
}

resource "aws_kinesis_stream" "main" {
  name                      = var.name
  shard_count               = local.is_provisioned_mode ? var.shard_count : null
  retention_period          = var.retention_hours
  shard_level_metrics       = var.shard_level_metrics
  enforce_consumer_deletion = true
  encryption_type           = "KMS"
  kms_key_id                = "alias/aws/kinesis"

  stream_mode_details {
    stream_mode = var.stream_mode
  }

  // Ignore future changes on the desired count value
  lifecycle {
    ignore_changes = [shard_count]
  }
}

resource "aws_iam_policy" "read" {
  name        = "kinesis-stream-${var.name}-read"
  description = "Read only policy for ${var.name} kinesis stream"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "kinesis:DescribeLimits",
          "kinesis:DescribeStream",
          "kinesis:GetRecords",
          "kinesis:GetShardIterator",
          "kinesis:SubscribeToShard",
          "kinesis:ListShards"
        ]
        Resource = [
          aws_kinesis_stream.main.arn
        ]
      }
    ])
  })
}

resource "aws_iam_policy" "write" {
  name        = "kinesis-stream-${var.name}-write"
  description = "Write only policy for ${var.name} kinesis stream"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "kinesis:DescribeStream",
          "kinesis:PutRecord",
          "kinesis:PutRecords",
        ]
        Resource = [
          aws_kinesis_stream.main.arn
        ]
      }
    ])
  })
}

resource "aws_iam_policy" "manage" {
  name        = "kinesis-stream-${var.name}-manage"
  description = "Kinesis policy for resharding stream"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = concat([
      {
        Effect = "Allow"
        Action = [
          "kinesis:*",
        ]
        Resource = [
          aws_kinesis_stream.main.arn
        ]
      }
    ])
  })
}
