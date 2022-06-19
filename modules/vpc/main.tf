# vpc 리소스
resource "aws_vpc" "vpc" {
  # instance_tenancy : 인스턴스 생성 가능 여부
  # enable_dns_hostnames : vpc에 dns hostname 사용 가능 여부
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

# 인터넷 게이트웨이 리소스
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}
