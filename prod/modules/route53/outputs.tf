output route53_zone_id {
  value       = data.aws_route53_zone.route53.zone_id
  sensitive   = true
  description = "route53_zone_id"
  depends_on  = []
}
