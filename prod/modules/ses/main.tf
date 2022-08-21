data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}

resource "aws_ses_domain_identity" "fooiy" {
  domain = "fooiy.com"
}

resource "aws_route53_record" "fooiy_amazonses_verification_record" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "_amazonses.fooiy.com"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.fooiy.verification_token]
}
