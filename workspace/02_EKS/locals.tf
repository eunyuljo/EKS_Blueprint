provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../01_VPC/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}

# 02_EKS의 workspace 에 따라 아래 내용은 바뀜
locals {
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr             = data.terraform_remote_state.vpc.outputs.vpc_cidr
  azs                  = data.terraform_remote_state.vpc.outputs.azs
  public_subnets_cidrs = data.terraform_remote_state.vpc.outputs.public_subnets_cidrs
  private_subnets_cidrs = data.terraform_remote_state.vpc.outputs.private_subnets_cidrs
}

locals {
  name   = "ex-${terraform.workspace}"
  region = "ap-northeast-2"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}