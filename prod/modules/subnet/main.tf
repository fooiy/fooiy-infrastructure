module "subnet_public_a" {
  source            = "./modules/subnet_public_a"
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones.a
}

module "subnet_public_c" {
  source            = "./modules/subnet_public_c"
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones.c
}

module "subnet_private_a" {
  source            = "./modules/subnet_private_a"
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones.a
}

module "subnet_private_c" {
  source            = "./modules/subnet_private_c"
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones.c
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private_subnet_group"
  subnet_ids = [module.subnet_private_a.id, module.subnet_private_c.id]

  tags = {
    Name = "private_subnet_group"
  }
}