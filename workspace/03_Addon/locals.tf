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

# data "terraform_remote_state" "eks" {
#   backend = "local"
#   config = {
#     path = "../02_EKS/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
#   }
# }

locals {

####### V2 ########

  # 현재 워크스페이스를 기준으로, 동일한 workspace의 이름의 backend를 참고할 수 있도록 생성해주었다.

  workspace_state_mapping = {
    "${terraform.workspace}" = "env:/${terraform.workspace}/backend/terraform.tfstate"
    #"default"    = "env:/default/terraform.tfstate"
    }
  current_state_key = lookup(local.workspace_state_mapping, terraform.workspace, "default/terraform.tfstate")

  workspace_state_vpc_mapping = {
    "${terraform.workspace}" = "env:/${terraform.workspace}/vpc/terraform.tfstate"
    #"default"    = "env:/default/terraform.tfstate"
    }
  current_state_vpc_key = lookup(local.workspace_state_vpc_mapping, terraform.workspace, "default/terraform.tfstate")

  workspace_state_eks_mapping = {
    "${terraform.workspace}" = "env:/${terraform.workspace}/eks/terraform.tfstate"
    #"default"    = "env:/default/terraform.tfstate"
    }
  current_state_eks_key = lookup(local.workspace_state_eks_mapping, terraform.workspace, "default/terraform.tfstate")


 #_locals_end
}


data "terraform_remote_state" "backend" {
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

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-backend20241118070404687300000001"  # S3 버킷 이름
    key    = local.current_state_eks_key                       # 현재 워크스페이스에 해당하는 상태 파일 경로
    region = "ap-northeast-2"
  }
}

locals {

  name                               = data.terraform_remote_state.backend.outputs.defaults.name
  region                             = data.terraform_remote_state.backend.outputs.defaults.region
  global_tag                         = data.terraform_remote_state.backend.outputs.global_tag
  vpc_id                             = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr                           = data.terraform_remote_state.vpc.outputs.vpc_cidr
  azs                                = data.terraform_remote_state.vpc.outputs.azs
  public_subnets_ids                 = data.terraform_remote_state.vpc.outputs.public_subnets_cidrs
  private_subnet_ids                 = data.terraform_remote_state.vpc.outputs.private_subnets_cidrs
  cluster_name                       = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_version                    = data.terraform_remote_state.eks.outputs.cluster_version
  #cluster_id                        = data.terraform_remote_state.eks.outputs.cluster_id
  cluster_endpoint                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  oidc_provider                      = data.terraform_remote_state.eks.outputs.oidc_provider
  oidc_provider_arn                  = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }

}

