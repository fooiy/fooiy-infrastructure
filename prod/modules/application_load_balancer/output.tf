output "prod_web_load_balancer_dns_name" {
    value = aws_lb.prod_web_load_balancer.dns_name
}
output "prod_web_load_balancer_zone_id" {
    value = aws_lb.prod_web_load_balancer.zone_id
}