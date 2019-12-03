# Backend-S3
Terraform module that creates an S3 bucket and DynamoDB table for backend state files.

## Usage
```hcl
module "backend-s3" {
  source = "github.com/byu-oit/terraform-aws-backend-s3"
}
```

Run `terraform apply` to create the S3 bucket and DynamoDB table for storing state files. Then add:
```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-<account_number>"
    lock_table = "terraform-state-lock-<account_number>"
    key = "my-cool-app.tfstate"
    region = "us-west-2"
  }
}
```
to configure your terraform backend to the newly created S3 bucket and DynamoDB table.


## Input Variables
| Variable | Default | Description |
| --- | --- | --- |
| bucket_name | terraform-state-<account_number> | S3 bucket name for state file storage |
| dynamodb_table_name | terraform-state-lock-<account_number> | DynamoDB table name for state file locking|

## Output Variables
* s3_bucket (S3 object)
* s3_bucket_name
* dynamodb_table (DynamoDB object)