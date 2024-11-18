provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

# data "terraform_remote_state" "Backend" {
#   backend = "local"
#   config = {
#     path = "../00_Backend/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
#   }
# }

# data "terraform_remote_state" "vpc" {
#   backend = "local"
#   config = {
#     path = "../01_VPC/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
#   }
# }

locals {
  # workspace_state_mapping = {
  #   "workspace1" = "env:/workspace1/backend/terraform.tfstate"
  #   "workspace2" = "env:/workspace2/backend/terraform.tfstate"
  #   "default"    = "env:/default/terraform.tfstate"
  #   }
  # current_state_key = lookup(local.workspace_state_mapping, terraform.workspace, "default/terraform.tfstate")

  # workspace_state_vpc_mapping = {
  #   "workspace1" = "env:/workspace1/vpc/terraform.tfstate"
  #   "workspace2" = "env:/workspace2/vpc/terraform.tfstate"
  #   "default"    = "env:/default/terraform.tfstate"
  #   }
  # current_state_vpc_key = lookup(local.workspace_state_vpc_mapping, terraform.workspace, "default/terraform.tfstate")

  workspace_state_mapping = {
    "${terraform.workspace}" = "env:/${terraform.workspace}/backend/terraform.tfstate"
    "default"    = "env:/default/terraform.tfstate"
    }
  current_state_key = lookup(local.workspace_state_mapping, terraform.workspace, "default/terraform.tfstate")

  workspace_state_vpc_mapping = {
    "${terraform.workspace}" = "env:/${terraform.workspace}/vpc/terraform.tfstate"
    "default"    = "env:/default/terraform.tfstate"
    }
  current_state_vpc_key = lookup(local.workspace_state_vpc_mapping, terraform.workspace, "default/terraform.tfstate")


}

data "terraform_remote_state" "Backend" {
  backend = "s3"
  config = {
    bucket = "terraform-backend20241118070404687300000001"  # S3 버킷 이름
    key    = local.current_state_key                       # 현재 워크스페이스에 해당하는 상태 파일 경로
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-backend20241118070404687300000001"  # S3 버킷 이름
    key    = local.current_state_vpc_key                       # 현재 워크스페이스에 해당하는 상태 파일 경로
    region = "ap-northeast-2"
  }
}









# 02_EKS의 workspace 에 따라 아래 내용은 바뀜
locals {

  cluster_version      = data.terraform_remote_state.Backend.outputs.cluster_version
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