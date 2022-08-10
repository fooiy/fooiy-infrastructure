output "load_balancer_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}

output "load_balancer_zone_id" {
  value = aws_alb.application_load_balancer.zone_id
}
