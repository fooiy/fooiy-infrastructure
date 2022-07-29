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

resource "aws_lb_listener" "prod_web_load_balancer_listener_http" {
  depends_on = [aws_acm_certificate.fooiy_certification]
  load_balancer_arn = aws_lb.prod_web_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_web_target_group.arn
  }
}

resource "aws_lb_listener_rule" "forward_https" {
  listener_arn = aws_lb_listener.prod_web_load_balancer_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_web_target_group.arn
  }

  condition {
    host_header {
      values = ["www.fooiy.com"]
    }
  }
}

resource "aws_lb_listener" "prod_web_load_balancer_listener_https" {
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

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.prod_web_load_balancer_listener_http.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.fooiy.com"]
    }
  }
}

