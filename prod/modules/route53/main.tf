data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}

resource "aws_route53_record" "dev-api" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "dev-api.${data.aws_route53_zone.route53.name}"
  type    = "A"
  ttl     = "300"
  records = var.dev_api_ec2_ip
}

resource "aws_route53_record" "admin" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "admin.${data.aws_route53_zone.route53.name}"
  type    = "A"
  ttl     = "300"
  records = var.prod_admin_ec2_ip
}



