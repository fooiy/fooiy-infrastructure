# Configure the AWS Provider
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
  vpc_dev_api_security_group_ids = [module.security_group.dev_api_ec2_security_group_id]
  vpc_prod_web_security_group_ids = [module.security_group.prod_web_ec2_security_group_id]
  vpc_prod_admin_security_group_ids = [module.security_group.prod_admin_ec2_security_group_id]
  vpc_vpn_security_group_ids = [module.security_group.vpn_ec2_security_group_id]
  availability_zones     = var.availability_zones
  subnet_a_id            = module.subnet.subnet_public_a_id
  subnet_c_id            = module.subnet.subnet_public_c_id
}

module "rds" {
  source  = "./modules/rds"
  vpc_id  = module.vpc.id
  subnets = [module.subnet.subnet_private_a_id, module.subnet.subnet_private_c_id]
  db_subnet_group_name = module.subnet.private_subnet_group_name
  vpc_security_group_ids = [module.security_group.dev_api_ec2_security_group_id, module.security_group.vpn_ec2_security_group_id]
}

module "s3"{
  source = "./modules/s3"
}

module "route53"{
  source = "./modules/route53"
  dev_api_ec2_ip = [module.ec2.dev_api_ec2_ip]
  prod_admin_ec2_ip = [module.ec2.prod_admin_ec2_ip]
  prod_web_load_balancer_dns_name = module.application_load_balancer.prod_web_load_balancer_dns_name
  prod_web_load_balancer_zone_id = module.application_load_balancer.prod_web_load_balancer_zone_id
}

module "application_load_balancer"{
  source = "./modules/application_load_balancer"

  vpc_id = module.vpc.id
  subnets = [module.subnet.subnet_public_c_id, module.subnet.subnet_public_a_id]
  security_groups = [module.security_group.prod_web_ec2_security_group_id]
  prod_web_instance_id = module.ec2.prod_web_ec2_id
}