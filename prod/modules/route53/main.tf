data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "dev-api.${data.aws_route53_zone.route53.name}"
  type    = "A"
  ttl     = "300"
  records = var.dev_api_ec2_ip
}