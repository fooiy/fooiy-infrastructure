module "prod_web_load_balancer" {
  source = "./application_load_balancer"

  application_load_balancer_name = "prod-web-load-balancer"
  load_balancer_target_group_name = "prod-web-target-group"
  aws_lb_listener_rule_host_value = "www.fooiy.com"

  vpc_id = var.vpc_id
  security_groups = var.prod_web_security_groups
  subnets = var.prod_web_subnets
  health_check_path = "/"
}

resource "aws_lb_target_group_attachment" "prod_web_target_group_attachment" {
  target_group_arn = module.prod_web_load_balancer.target_group_arn
  target_id        = var.prod_web_instance_id
  port             = 80
}

module "prod_api_load_balancer" {
  source = "./application_load_balancer"
  application_load_balancer_name = "prod-api-load-balancer"
  load_balancer_target_group_name = "prod-api-target-group"
  aws_lb_listener_rule_host_value = "api.fooiy.com"

  vpc_id = var.vpc_id
  security_groups = var.prod_api_security_groups
  subnets = var.prod_api_subnets
  health_check_path = "/health_check"
  target_type = "ip"
}