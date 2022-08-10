resource "aws_alb_target_group" "load_balancer_target_group" {
  name     = "prod-web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200-302"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_target_group_attachment" "prod_web_target_group_attachment" {
  target_group_arn = aws_alb_target_group.load_balancer_target_group.arn
  target_id        = var.instance_id
  port             = 80
}
