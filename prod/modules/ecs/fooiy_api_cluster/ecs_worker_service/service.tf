resource "aws_ecs_service" "worker" {
  name            = "worker"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.worker_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = true
  }

  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }
}

