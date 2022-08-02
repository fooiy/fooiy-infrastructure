output target_group_arn {
  value       = aws_lb_target_group.load_balancer_target_group.arn
  sensitive   = true
  description = "target_group_arn"
  depends_on  = []
}
output "load_balancer_arn" {
    value = aws_lb.application_load_balancer.arn
}
output "load_balancer_dns_name" {
    value = aws_lb.application_load_balancer.dns_name
}
output "load_balancer_zone_id" {
    value = aws_lb.application_load_balancer.zone_id
}
