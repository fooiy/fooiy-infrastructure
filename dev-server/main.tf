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
    subnet_az = var.subnet_az
    is_public = true
    vpc_name = var.vpc_name
}

module "routing_table" {
    source = "../modules/routing_table"

    vpc_id = module.vpc.vpc_id
    igw_id = module.vpc.igw_id
    vpc_name = var.vpc_name
    subnet_id = module.public_subnet.subnet_id
    
}

module "dev_ec2_sg" {
    source = "../modules/security_group"

    vpc_name = var.vpc_name
    vpc_id = module.vpc.vpc_id
    from_port = var.from_port
    to_port = var.to_port
    protocol = var.protocol
    sg_cidr_block = var.sg_cidr_block
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
