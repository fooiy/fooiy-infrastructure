resource "aws_alb_listener" "load_balancer_listener_http" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "load_balancer_listener_https" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.fooiy_certification.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.prod_api_load_balancer_target_group.arn
  }

  depends_on = [data.aws_acm_certificate.fooiy_certification]
}

resource "aws_alb_listener" "redis_commander_load_balancer_listener_http" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.redis_commander_load_balancer_target_group.arn
  }
}
