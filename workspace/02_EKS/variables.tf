variable "cluster_tags" {
  description = "Addtitional tags"
  type = map(string)
  default = {}
}

variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {}
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




# eyjo Workloads Git
variable "gitops_workload_org" {
  description = "Git repository org/user contains for workload"
  type        = string
  default     = "https://github.com/eunyuljo"
}
variable "gitops_workload_repo" {
  description = "Git repository contains for workload"
  type        = string
  default     = "eks-blueprints-workloads"
}
variable "gitops_workload_revision" {
  description = "Git repository revision/branch/ref for workload"
  type        = string
  default     = "main"
}
variable "gitops_workload_basepath" {
  description = "Git repository base path for workload"
  type        = string
  default     = "k8s"
}
variable "gitops_workload_path" {
  description = "Git repository path for workload"
  type        = string
  default     = "envs/eyjo"
}



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