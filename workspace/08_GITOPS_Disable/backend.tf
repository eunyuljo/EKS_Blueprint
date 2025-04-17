terraform {
  # 일반적인 환경변수를 정의하는 폴더 - 하나의 폴더에서 workspace별 eks 내용만 담고 있는 terraform.tfstate 파일
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-backend20241118070404687300000001"
    key            = "gitops/terraform.tfstate"
    dynamodb_table = "terraform_state"
  }
}

