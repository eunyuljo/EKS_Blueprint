locals{
    cluster_name                           = module.eks_al2023.cluster_name
    cluster_endpoint                       = module.eks_al2023.cluster_endpoint
    cluster_certificate_authority_data     = base64decode(module.eks_al2023.cluster_certificate_authority_data)
}

data "aws_caller_identity" "current" {}

provider "kubernetes" {
  host                   = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_certificate_authority_data
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
    command     = "aws"
  }
}


provider "helm" {
  kubernetes {
    host                   = module.eks_al2023.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_al2023.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks_al2023.cluster_name, "--region", local.region]
    }
  }
}
