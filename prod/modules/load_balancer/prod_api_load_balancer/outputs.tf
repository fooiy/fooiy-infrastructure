output "load_balancer_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}

output "load_balancer_zone_id" {
  value = aws_alb.application_load_balancer.zone_id
}

output "prod_api_target_group_arn" {
  value = aws_alb_target_group.prod_api_load_balancer_target_group.arn
}

output "redis_commander_target_group_arn" {
  value = aws_alb_target_group.redis_commander_load_balancer_target_group.arn
}
