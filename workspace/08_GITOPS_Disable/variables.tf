# variable "vpc_cidr" {
#   description = "VPC CIDR"
#   type        = string
#   default     = "10.0.0.0/16"
# }
# variable "region" {
#   description = "AWS region"
#   type        = string
#   default     = "ap-northeast-2"
# }
# variable "kubernetes_version" {
#   description = "Kubernetes version"
#   type        = string
#   default     = "1.30"
# }


variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {
    # enable_aws_load_balancer_controller = true
    # enable_metrics_server               = true
    # enable_cert_manager                 = true
    # enable_ingress_nginx                = true
  }
}

# Addons Git
variable "gitops_addons_org" {
  description = "Git repository org/user contains for addons"
  type        = string
  default     = "https://github.com/eunyuljo/"
}
variable "gitops_addons_repo" {
  description = "Git repository contains for addons"
  type        = string
  default     = "eks-blueprints-add-ons"
}
variable "gitops_addons_revision" {
  description = "Git repository revision/branch/ref for addons"
  type        = string
  default     = "main"
}
variable "gitops_addons_basepath" {
  description = "Git repository base path for addons"
  type        = string
  default     = "argocd/"
}
variable "gitops_addons_path" {
  description = "Git repository path for addons"
  type        = string
  default     = "bootstrap/control-plane/addons"
}

# Workloads Git
variable "gitops_workload_org" {
  description = "Git repository org/user contains for workload"
  type        = string
  default     = "https://github.com/eunyuljo"
}
variable "gitops_workload_repo" {
  description = "Git repository contains for workload"
  type        = string
  default     = "eks-blueprints-workload"
}
variable "gitops_workload_revision" {
  description = "Git repository revision/branch/ref for workload"
  type        = string
  default     = "main"
}
variable "gitops_workload_basepath" {
  description = "Git repository base path for workload"
  type        = string
  default     = "k8s/"
}
variable "gitops_workload_path" {
  description = "Git repository path for workload"
  type        = string
  default     = "/"
}
