provider "aws" {
  region = "us-west-2"
}

module "backend-s3" {
  source = "../"
}

output "s3" {
  value = module.backend-s3.s3_bucket
}