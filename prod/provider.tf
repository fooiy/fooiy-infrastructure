provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "fooiy_tfstate" {
  bucket = "fooiy-s3-bucket-tfstate"
}

resource "aws_s3_bucket_versioning" "fooiy_versioning" {
  bucket = aws_s3_bucket.fooiy_tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-tfstate-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# 위의 버킷과 몽고 디비가 없으면 아래의 코드를 주석처리한 후 버킷과 디비를 만들고 실행
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend s3 {
    bucket         = "fooiy-s3-bucket-tfstate" # S3 버킷 이름
    key            = "terraform/terraform.tfstate" # tfstate 저장 경로
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-tfstate-lock" # dynamodb table 이름
  }
}

