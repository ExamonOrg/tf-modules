#https://github.com/cloudposse/terraform-aws-dynamodb/blob/main/variables.tf
#https://github.com/cloudposse/terraform-aws-s3-website
#https://github.com/orgs/cloudposse/
#https://github.com/cloudposse/terraform-aws-step-functions


resource "aws_dynamodb_table" "default" {
  name                        = var.table_name
  billing_mode                = var.billing_mode
  read_capacity               = var.billing_mode == "PAY_PER_REQUEST" ? null : var.autoscale_min_read_capacity
  write_capacity              = var.billing_mode == "PAY_PER_REQUEST" ? null : var.autoscale_min_write_capacity
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  stream_enabled              = length(var.replicas) > 0 ? true : var.enable_streams
  stream_view_type            = length(var.replicas) > 0 || var.enable_streams ? var.stream_view_type : ""
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled

  server_side_encryption {
    enabled     = var.enable_encryption
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }

  dynamic "attribute" {
    for_each = var.dynamodb_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  dynamic "replica" {
    for_each = var.replicas
    content {
      region_name = replica.value
      # If kms_key_arn is null, the provider uses the default key
      kms_key_arn            = null
      propagate_tags         = false
      point_in_time_recovery = false
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_enabled ? [1] : []
    content {
      attribute_name = var.ttl_attribute
      enabled        = var.ttl_enabled
    }
  }

}
