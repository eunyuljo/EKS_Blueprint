module "eks_al2023" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "ex-${terraform.workspace}"
  cluster_version = local.cluster_version

  # EKS Addons
  # cluster_addons = {
  #   coredns                = {}
  #   eks-pod-identity-agent = {}
  #   kube-proxy             = {}
  #   vpc-cni                = {}
  # }

  # 생성한 워크스페이스 기준으로 기입된 네트워크 참고
  vpc_id     = local.vpc_id
  subnet_ids = local.private_subnets_cidrs

  # 생성한 사용자에게 권한 부여 여부
  enable_cluster_creator_admin_permissions = true

  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
    ingress_https = {
      description                = "kubectl"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "ingress"
      cidr_blocks                = ["10.0.0.0/16"]
    }
  }

    # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }


  eks_managed_node_groups = {
    "${terraform.workspace}-nodegroup" = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["m6i.large"]
      capacity_type  = "SPOT"

      min_size = 3
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 3
    }
  }

  tags = local.tags
}