provider "aws" {
    region = "ap-northeast-2"
}

module "vpc" {
    source = "../modules/vpc"

    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
}

module "public_subnet" {
    source = "../modules/subnet"

    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.public_subnet_cidr[0]
    subnet_az = var.subnet_az[0]
    is_public = true
    vpc_name = var.vpc_name
    igw_id = module.vpc.igw_id
    subnet_usage = ""
}

module "private_db_subnet" {
    source = "../modules/subnet"

    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.private_subnet_cidr[0]
    subnet_az = var.subnet_az[1]
    is_public = false
    vpc_name = var.vpc_name
    igw_id = module.vpc.igw_id
    subnet_usage = "db"
}

module "private_api_subnet" {
    source = "../modules/subnet"

    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.private_subnet_cidr[1]
    subnet_az = var.subnet_az[2]
    is_public = false
    vpc_name = var.vpc_name
    igw_id = module.vpc.igw_id
    subnet_usage = "api"
}

module "web_ec2" {
    source = "../modules/ec2"

    images = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = data.aws_key_pair.fooiy-web-key.key_name
    security_group_ids = aws_security_group.web_sg.id
    subnet_id = module.public_subnet.subnet_id
    vpc_name = var.vpc_name
    ec2_usage = "web"
}

module "dev_api_ec2" {
    source = "../modules/ec2"

    images = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = data.aws_key_pair.fooiy-dev-key.key_name
    security_group_ids = aws_security_group.dev_api_sg.id
    subnet_id = module.public_subnet.subnet_id
    vpc_name = var.vpc_name
    ec2_usage = "dev-api"
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private_subnet_group"
  subnet_ids = [module.private_api_subnet.subnet_id, module.private_db_subnet.subnet_id]

  tags = {
    Name = "private_subnet_group"
  }
}

module "dev_rds"{
    source = "../modules/rds_master"

    db_subnet_group_name = aws_db_subnet_group.private_subnet_group.name
    rds_allocated_storage = var.rds_allocated_storage 
    rds_engine = var.rds_engine 
    rds_engine_version = var.rds_engine_version 
    rds_instance_class = var.rds_instance_class 
    rds_name = var.rds_name 
    rds_username = var.rds_username 
    rds_password = var.rds_password 
    rds_parameter_group_name = var.rds_parameter_group_name 
    rds_skip_final_snapshot = var.rds_skip_final_snapshot 
    rds_vpc_security_group_ids = [aws_security_group.dev_api_sg.id]
}

module "dev_s3"{
    source = "../modules/s3"
    
    bucket_name = "fooiy-dev"
    usage = "dev"
}