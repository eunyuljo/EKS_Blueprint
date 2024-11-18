locals {
  default = {
    region = "ap-northeast-2"
    name = "ex-${terraform.workspace}"
  }

  global_tag = {}

  eks_info = tomap({
    "workspace1" = {
      cluster_version = "1.29"
      nodegroup = {}
    }
    "workspace2" = {
      cluster_version = "1.30"
      nodegroup = {}
    }
    "workspace3" = {
      cluster_version = "1.31"
      nodegroup = {}
    }
  })


  # 각 환경별로 선언한 내용을 local로 다시 분류하여 담는다.
  cluster_version = local.eks_info[terraform.workspace].cluster_version
}
