provider "aws" {
  region = "us-west-2"
}

module "backend_s3" {
  source = "github.com/byu-oit/terraform-aws-backend-s3?ref=v1.1.0"
}

output "s3" {
  value = module.backend_s3.s3_bucket
}
