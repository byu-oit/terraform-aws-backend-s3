data "aws_caller_identity" "current" {}

locals {
  default_bucket_name         = "terraform-state-storage-${data.aws_caller_identity.current.account_id}"
  default_dynamodb_table_name = "terraform-state-lock-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "terraform-state-storage" {
  bucket = var.bucket_name == "" ? local.default_bucket_name : var.bucket_name
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state-storage-versioning" {
  bucket = aws_s3_bucket.terraform-state-storage.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "state-storage-abort-failed-multipart" {
  bucket = aws_s3_bucket.terraform-state-storage.bucket
  rule {
    id     = "AutoAbortFailedMultipartUpload"
    status = "Enabled"
    abort_incomplete_multipart_upload {
      days_after_initiation = 10
    }
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "state-storage-encrypted" {
  bucket = aws_s3_bucket.terraform-state-storage.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.terraform-state-storage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name         = var.dynamodb_table_name == "" ? local.default_dynamodb_table_name : var.dynamodb_table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true
  }
}
