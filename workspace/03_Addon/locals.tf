data "terraform_remote_state" "Backend" {
  backend = "local"
  config = {
    path = "../00_Backend/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../01_VPC/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../02_EKS/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}

locals {

  name = data.terraform_remote_state.Backend.outputs.default.name
  region = data.terraform_remote_state.Backend.outputs.default.region
  global_tag = data.terraform_remote_state.Backend.outputs.global_tag


  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr             = data.terraform_remote_state.vpc.outputs.vpc_cidr
  azs                  = data.terraform_remote_state.vpc.outputs.azs
  public_subnets_ids   = data.terraform_remote_state.vpc.outputs.public_subnets_cidrs
  private_subnet_ids   = data.terraform_remote_state.vpc.outputs.private_subnets_cidrs

  cluster_name         = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_version      = data.terraform_remote_state.eks.outputs.cluster_version
  #cluster_id           = data.terraform_remote_state.eks.outputs.cluster_id
  cluster_endpoint     = data.terraform_remote_state.eks.outputs.cluster_endpoint
  oidc_provider        = data.terraform_remote_state.eks.outputs.oidc_provider
  oidc_provider_arn    = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.eks_cluster_certificate_authority_data

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }

}
