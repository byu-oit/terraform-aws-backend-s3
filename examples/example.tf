provider "aws" {
  region = "us-west-2"
}

module "backend-s3" {
  source = "git@github.com/byu-oit/terraform-aws-backend-s3.git?ref=v1.0.2"
  ref = "v1.0.2"
}

output "s3" {
  value = module.backend-s3.s3_bucket
}
