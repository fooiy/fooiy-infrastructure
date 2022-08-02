resource "aws_lb" "application_load_balancer" {
  name               = var.application_load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups # list
  subnets            = var.subnets # list

  enable_deletion_protection = true

  tags = {
    Environment = "prod"
  }
}

resource "aws_lb_target_group" "load_balancer_target_group" {
  name     = var.load_balancer_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = var.target_type

  health_check {
    enabled             = true
    interval            = 300
    path                = var.health_check_path
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "load_balancer_listener_http" {
  depends_on        = [data.aws_acm_certificate.fooiy_certification]
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }
}

resource "aws_lb_listener_rule" "forward_https" {
  listener_arn = aws_lb_listener.load_balancer_listener_http.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }

  condition {
    host_header {
      values = [var.aws_lb_listener_rule_host_value]
    }
  }
}

resource "aws_lb_listener" "load_balancer_listener_https" {
  depends_on        = [data.aws_acm_certificate.fooiy_certification]
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.fooiy_certification.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.load_balancer_listener_http.arn

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
      values = [var.aws_lb_listener_rule_host_value]
    }
  }
}