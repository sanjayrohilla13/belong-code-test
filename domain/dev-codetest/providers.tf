# Terraform Providers.tf file needs to be updated for environment. 
terraform {
  backend "s3" {
    bucket         = "059114722599-tf-state-bucket"                    //update required for New Env 
    key            = "terraform/BelongCodeTest/dev/terraform.tfstate"  //update required for New Env
    dynamodb_table = "BelongCodeTest-dev-tf-state-lock"                //update required for New Env
    region         = "ap-southeast-2"
  }
  required_providers {
    aws = {
      version = "~> 4.22.0"
      source  = "hashicorp/aws"
    }
  }
}