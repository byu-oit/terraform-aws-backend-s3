variable "bucket_name" {
  description = "Bucket name for the S3 bucket to store state files"
  default     = ""
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for locking state files"
  default     = ""
}