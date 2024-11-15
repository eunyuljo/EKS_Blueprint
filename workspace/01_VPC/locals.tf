provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${terraform.workspace}"
  region = "ap-northeast-2"

  # workspace별로 네트워크 정보 정의
  network_info = tomap({
    "workspace1" = {
      vpc = {
        vpc_hand_made = "10.0.0.0/16"
        vpc_id = "vpc-00e7e31d7427ae524"
      }
      subnet = {
        subnet_hand_made = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
        subnet_make = {
          public_lb_subnet_hand_made  = ["subnet-0b8b02f5f559e65b6", "subnet-0e3639679afd9af3b", "subnet-06f3e33b54b7e9761"]
          private_subnet_hand_made    = ["subnet-044d9418d551a5386", "subnet-0bfe59237e8fdedd2", "subnet-0d6b3838ce2d68b53"]
        }
      }
    }
    "workspace2" = {
      vpc = {
        vpc_hand_made = "10.0.0.0/16"
        vpc_id = "vpc-0c859c2a6cece770b"
      }
      subnet = {
        subnet_hand_made = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
        subnet_make = {
          public_lb_subnet_hand_made  = ["subnet-0b8b02f5f559e65b6", "subnet-0e3639679afd9af3b", "subnet-06f3e33b54b7e9761"]
          private_subnet_hand_made    = ["subnet-044d9418d551a5386", "subnet-0bfe59237e8fdedd2", "subnet-0d6b3838ce2d68b53"]
        }
      }
    }
    "workspace3" = {
      vpc = {
        vpc_hand_made = "10.0.0.0/16"
        vpc_id = "vpc-00e7e31d7427ae524"
      }
      subnet = {
        subnet_hand_made = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
        subnet_make = {
          public_lb_subnet_hand_made  = ["subnet-yyyyyyyyyyyyyyyyy", "subnet-yyyyyyyyyyyyyyyyy", "subnet-yyyyyyyyyyyyyyyyy"]
          private_subnet_hand_made    = ["subnet-yyyyyyyyyyyyyyyyy", "subnet-yyyyyyyyyyyyyyyyy", "subnet-yyyyyyyyyyyyyyyyy"]
        }
      }
    }
  })

  # 환경별로 선택된 네트워크 정보를 로컬 변수에 할당
  vpc_cidr             = local.network_info[terraform.workspace].vpc.vpc_hand_made
  vpc_id               = local.network_info[terraform.workspace].vpc.vpc_id
  azs                  = local.network_info[terraform.workspace].subnet.subnet_hand_made
  public_subnets_cidrs = local.network_info[terraform.workspace].subnet.subnet_make.public_lb_subnet_hand_made
  private_subnets_cidrs = local.network_info[terraform.workspace].subnet.subnet_make.private_subnet_hand_made

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}