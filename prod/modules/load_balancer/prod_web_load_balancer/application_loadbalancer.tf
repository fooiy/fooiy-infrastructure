resource "aws_alb" "application_load_balancer" {
  name               = "prod-web-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups # list
  subnets            = var.subnets         # list

  enable_deletion_protection = true

  tags = {
    Environment = "prod"
  }
}
