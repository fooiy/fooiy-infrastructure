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

