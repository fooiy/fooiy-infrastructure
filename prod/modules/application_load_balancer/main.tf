resource "aws_lb" "prod_web_load_balancer" {
  name               = "prod-web-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups # list
  subnets            = var.subnets # list

  enable_deletion_protection = true

  tags = {
    Environment = "prod"
  }
}

resource "aws_lb_target_group" "prod_web_target_group" {
  name     = "prod-web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "prod_web_target_group_attachment" {
  target_group_arn = aws_lb_target_group.prod_web_target_group.arn
  target_id        = var.prod_web_instance_id
  port             = 80
}

resource "aws_lb_listener" "prod_web_load_balancer_listener" {
  depends_on = [aws_acm_certificate.fooiy_certification]
  load_balancer_arn = aws_lb.prod_web_load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.fooiy_certification.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_web_target_group.arn
  }
}

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

