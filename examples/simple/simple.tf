provider "aws" {
  region = "us-west-2"
}

module "backend-s3" {
  source = "github.com/byu-oit/terraform-aws-backend-s3?ref=v1.0.4"
}

output "s3" {
  value = module.backend-s3.s3_bucket
}
