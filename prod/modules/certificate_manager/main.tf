# 인증서 등록 및 라우터53 연결
resource "aws_acm_certificate" "fooiy_certification" {
  domain_name       = "*.fooiy.com"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "fooiy_certification_validation_route53" {
  for_each = {
    for dvo in aws_acm_certificate.fooiy_certification.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53.zone_id
}


resource "aws_acm_certificate_validation" "fooiy_certification_validation" {
  certificate_arn         = aws_acm_certificate.fooiy_certification.arn
  validation_record_fqdns = [for record in aws_route53_record.fooiy_certification_validation_route53 : record.fqdn]
}


# 인증서 등록 및 라우터53 연결
resource "aws_acm_certificate" "fooiy_root_certification" {
  domain_name       = "fooiy.com"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "fooiy_root_certification_validation_route53" {
  for_each = {
    for dvo in aws_acm_certificate.fooiy_root_certification.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53.zone_id
}


resource "aws_acm_certificate_validation" "fooiy_root_certification_validation" {
  certificate_arn         = aws_acm_certificate.fooiy_root_certification.arn
  validation_record_fqdns = [for record in aws_route53_record.fooiy_root_certification_validation_route53 : record.fqdn]
}
