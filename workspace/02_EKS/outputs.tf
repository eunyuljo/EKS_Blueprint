output "cluster_name" {
  value = module.eks_al2023.cluster_name
}

output "cluster_version" {
  value = module.eks_al2023.cluster_version
}

output "cluster_id" {
  value = module.eks_al2023.cluster_id
}

output "cluster_endpoint" {
  value = module.eks_al2023.cluster_endpoint
}

output "oidc_provider" {
  value = module.eks_al2023.oidc_provider
}

output "oidc_provider_arn" {
  value = module.eks_al2023.oidc_provider_arn
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks_al2023.cluster_certificate_authority_data
}

