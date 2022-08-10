resource "aws_ecs_service" "redis_commander" {
  name            = "redis_commander"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.redis_commander_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "redis-commander-fooiy"
    container_port   = 8081
  }

  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }
}
