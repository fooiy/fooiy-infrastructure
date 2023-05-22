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

resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "fooiy.com"
  type    = "A"

  alias {
    name                   = var.prod_web_load_balancer_dns_name
    zone_id                = var.prod_web_load_balancer_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "www.fooiy.com"
  type    = "A"

  alias {
    name                   = var.prod_web_load_balancer_dns_name
    zone_id                = var.prod_web_load_balancer_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "api.fooiy.com"
  type    = "A"

  alias {
    name                   = var.prod_api_load_balancer_dns_name
    zone_id                = var.prod_api_load_balancer_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "email" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "email.fooiy.com"
  type    = "MX"
  ttl     = "300"
  records = ["10 ASPMX.daum.net.", "20 ALT.ASPMX.daum.net."]
}
