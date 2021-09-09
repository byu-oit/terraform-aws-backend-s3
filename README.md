# Terraform AWS Backend S3
Terraform module that creates an S3 bucket and DynamoDB table for backend state files.

## Quickstart

This is one of the few modules that you can just run "as is" and then throw away the config and state.

```sh
git clone https://github.com/byu-oit/terraform-aws-backend-s3.git
cd terraform-aws-backend-s3/examples/simple
aws sso login
export AWS_PROFILE=my-account-profile
terraform init
terraform apply
cd ../../../
rm -rf terraform-aws-backend-s3
```

## Usage
```hcl
module "backend-s3" {
  source = "github.com/byu-oit/terraform-aws-backend-s3?ref=v1.0.5"
}
```

Run `terraform apply` to create the S3 bucket and DynamoDB table for storing state files. Then add:
```hcl
terraform {
  backend "s3" {
    bucket          = "terraform-state-storage-<account_number>"
    dynamodb_table  = "terraform-state-lock-<account_number>"
    key             = "my-cool-app.tfstate"
    region          = "us-west-2"
  }
}
```
to configure your terraform backend to the newly created S3 bucket and DynamoDB table.


## Input
| Variable            | Default                                  | Description                                |
| ------------------- | ---------------------------------------- | ------------------------------------------ |
| bucket_name         | terraform-state-storage-<account_number> | S3 bucket name for state file storage      |
| dynamodb_table_name | terraform-state-lock-<account_number>    | DynamoDB table name for state file locking |

## Output
| Name           | Description                                                                                                                                    |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| s3_bucket      | S3 bucket [object](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#attributes-reference) for terraform state storage              |
| s3_bucket_name | Bucket name of the `s3_bucket`                                                                                                                 |
| dynamodb_table | DynamoDB Table [object](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#attributes-reference) for locking of terraform state |

**Note about returning objects:** Because objects are returned (as opposed to just values), autocomplete may not work. 
Just add on the key to the end out the output accessor. Even though autocomplete won't work, those values will still be 
correctly returned.
