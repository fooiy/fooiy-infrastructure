data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}

resource "aws_ses_domain_identity" "fooiy" {
  domain = "fooiy.com"
}

resource "aws_ses_domain_dkim" "fooiy" {
  domain = aws_ses_domain_identity.fooiy.domain
}

resource "aws_route53_record" "fooiy_amazonses_dkim_record" {
  count   = 3
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "${element(aws_ses_domain_dkim.fooiy.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.fooiy.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "fooiy_amazonses_verification_record" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = "_amazonses.fooiy.com"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.fooiy.verification_token]
}

resource "aws_ses_domain_mail_from" "fooiy" {
  domain           = aws_ses_domain_identity.fooiy.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.fooiy.domain}"
}

resource "aws_route53_record" "fooiy_ses_domain_mail_from_mx" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = aws_ses_domain_mail_from.fooiy.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.ap-northeast-2.amazonses.com"]
}

resource "aws_route53_record" "fooiy_ses_domain_mail_from_txt" {
  zone_id = data.aws_route53_zone.route53.zone_id
  name    = aws_ses_domain_mail_from.fooiy.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}
