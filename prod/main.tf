# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}
variable "availability_zones" {
  description = "availability zones"
  type = object({
    a = string
    b = string
    c = string
    d = string
  })
  default = {
    a = "ap-northeast-2a"
    b = "ap-northeast-2b"
    c = "ap-northeast-2c"
    d = "ap-northeast-2d"
  }
}

# ========== VPC ========== #
module "vpc" {
  source = "./modules/vpc"
}

# ========== Subnet ========== #
module "subnet" {
  source             = "./modules/subnet"
  vpc_id             = module.vpc.id
  availability_zones = var.availability_zones
}

# ========== Elastic IP ========== #
# module "elastic_ip" {
#   source = "./modules/elastic_ip"
# }

# ========== Internet Gateway ========== #
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.id
}

# ========== Route Table ========== #
module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.id
  internet_gateway_id = module.internet_gateway.dev_internet_gateway_id
  # nat_gateway_2a_id   = module.nat_gateway.nat_gateway_2a_id
  # nat_gateway_2c_id   = module.nat_gateway.nat_gateway_2c_id
  subnet_public_a_id  = module.subnet.subnet_public_a_id
  subnet_public_c_id  = module.subnet.subnet_public_c_id
  subnet_private_a_id = module.subnet.subnet_private_a_id
  subnet_private_c_id = module.subnet.subnet_private_c_id
}

# ========== Security Group ========== #
module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.id
}

# ========== EC2 ========== #
module "ec2" {
  source                 = "./modules/ec2"
  vpc_security_group_ids     = [module.security_group.dev_api_ec2_security_group_id]
  availability_zones     = var.availability_zones
  subnet_id              = module.subnet.subnet_public_a_id
}

module "rds" {
  source  = "./modules/rds"
  vpc_id  = module.vpc.id
  subnets = [module.subnet.subnet_private_a_id, module.subnet.subnet_private_c_id]
  db_subnet_group_name = module.subnet.private_subnet_group_name
  allowed_security_groups = [module.security_group.dev_api_ec2_security_group_id]

  ####### 실제 테스트 완료 시 추가!!
  # deletion_protection = true
}

module "s3"{
    source = "./modules/s3"
}

module "route53"{
    source = "./modules/route53"
    dev_api_ec2_ip = [module.ec2.dev_api_ec2_ip]
}