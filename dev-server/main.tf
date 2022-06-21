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
    igw_id = = module.vpc.igw_id
}

module "private_db_subnet" {
    source = "../modules/subnet"

    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.private_subnet_cidr[0]
    subnet_az = var.subnet_az[1]
    is_public = true
    vpc_name = var.vpc_name
}

module "private_api_subnet" {
    source = "../modules/subnet"

    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.private_subnet_cidr[0]
    subnet_az = var.subnet_az[2]
    is_public = true
    vpc_name = var.vpc_name
}

module "dev_ec2_sg" {
    source = "../modules/security_group"

    vpc_name = var.vpc_name
    vpc_id = module.vpc.vpc_id
    from_port = var.ec2_from_port
    to_port = var.ec2_to_port
    protocol = var.ec2_protocol
    sg_cidr_block = var.ec2_sg_cidr_block
}

module "dev_db_sg" {
    source = "../modules/security_group"

    vpc_name = var.vpc_name
    vpc_id = module.vpc.vpc_id
    from_port = var.rds_from_port
    to_port = var.rds_to_port
    protocol = var.rds_protocol
    security_group_id = module.dev_ec2_sg.sg_id 
}

module "dev_api_sg" {
    source = "../modules/security_group"

    vpc_name = var.vpc_name
    vpc_id = module.vpc.vpc_id
    from_port = var.rds_from_port
    to_port = var.rds_to_port
    protocol = var.rds_protocol
    security_group_id = module.dev_ec2_sg.sg_id 
}

module "dev_ec2" {
    source = "../modules/ec2"

    images = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = data.aws_key_pair.fooiy-dev-key.key_name
    security_group_ids = module.dev_ec2_sg.sg_id
    subnet_id = module.public_subnet.subnet_id
    vpc_name = var.vpc_name
    ec2_usage = var.ec2_usage
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private_subnet_group"
  subnet_ids = [module.private_api_subnet.subnet_id, module.private_db_subnet.subnet_id]

  tags = {
    Name = "private_subnet_group"
  }
}

module "rds" {
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
    rds_vpc_security_group_ids = [module.dev_rds_sg.sg_id]
}