locals{
    cluster_name                           = module.eks_al2023.cluster_name
    cluster_endpoint                       = module.eks_al2023.cluster_endpoint
    cluster_certificate_authority_data     = base64decode(module.eks_al2023.cluster_certificate_authority_data)
}


provider "kubernetes" {
  host                   = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_certificate_authority_data
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
    command     = "aws"
  }
}