locals {

  default = {
    region = "ap-northeast-2"
    name = "ex-${terraform.workspace}"
  }

  eks_info = {
    cluster_version = 1.29 
  }

  global_tag = {}
}


