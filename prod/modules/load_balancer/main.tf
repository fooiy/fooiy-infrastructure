module "prod_web_load_balancer" {
  source = "./prod_web_load_balancer"

  vpc_id          = var.vpc_id
  security_groups = var.prod_web_security_groups
  subnets         = var.prod_web_subnets
  instance_id     = var.prod_web_instance_id
}

module "prod_api_load_balancer" {
  source = "./prod_api_load_balancer"

  vpc_id          = var.vpc_id
  security_groups = var.prod_api_security_groups
  subnets         = var.prod_api_subnets
}
