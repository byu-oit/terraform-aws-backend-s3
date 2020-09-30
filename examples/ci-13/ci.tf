terraform {
  required_version = "0.13.2"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "backend_s3" {
  source = "../../"
}

output "s3_bucket" {
  value = module.backend_s3.s3_bucket
}

output "s3_bucket_name" {
  value = module.backend_s3.s3_bucket_name
}

output "lock_table" {
  value = module.backend_s3.lock_table
}
