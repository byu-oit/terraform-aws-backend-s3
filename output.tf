output "s3_bucket" {
  value = aws_s3_bucket.terraform-state-storage
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.terraform-state-storage.bucket
}

output "lock_table" {
  value = aws_dynamodb_table.dynamodb-terraform-state-lock
}