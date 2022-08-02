output "prod_web_load_balancer_dns_name" {
    value = module.prod_web_load_balancer.load_balancer_dns_name
}
output "prod_web_load_balancer_zone_id" {
    value = module.prod_web_load_balancer.load_balancer_zone_id
}

output "prod_api_load_balancer_dns_name" {
    value = module.prod_api_load_balancer.load_balancer_dns_name
}
output "prod_api_load_balancer_zone_id" {
    value = module.prod_api_load_balancer.load_balancer_zone_id
}

output prod_api_target_group_arn {
  value       = module.prod_api_load_balancer.target_group_arn
  sensitive   = true
  description = "prod_api_target_group_arn"
  depends_on  = []
}
