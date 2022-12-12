terraform {
  required_version = "1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
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
