resource "aws_ecs_service" "redis" {
  name            = "redis"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.api_redis_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  service_registries {
    registry_arn = aws_service_discovery_service.fooiy-api-redis.arn
  }

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

