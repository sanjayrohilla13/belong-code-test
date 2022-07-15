terraform {
  backend "s3" {
    # bucket         = "sanjay-rohilla"
    bucket         = "059114722599-tf-state-bucket"
    key            = "terraform/dev/code-test/terraform.tfstate"
    dynamodb_table = "dev-code-test-tf-state-lock"
    region         = "ap-southeast-2"
  }
  required_providers {
    aws = {
      version = "~> 4.22.0"
      source  = "hashicorp/aws"
    }
  }
}