terraform {

  # Comment this out when initialising resources.
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-backend20241118070404687300000001"
    key            = "vpc/terraform.tfstate"
    dynamodb_table = "terraform_state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}