terraform {
  required_version = "0.12.26"
}

provider "aws" {
  version = "~> 2.42"
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
