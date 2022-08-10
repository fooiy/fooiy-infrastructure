# 작업 정의
resource "aws_ecs_task_definition" "redis_commander_task_definition" {
  family                   = "prod_redis_commander_task_definition"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_execution_role_arn
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("modules/ecs/container_definition_environment.json.tftpl",
    {
      region             = "ap-northeast-2"
      aws_ecr_repository = "rediscommander/redis-commander"
      tag                = "latest"
      container_port     = 8081
      host_port          = 8081
      app_name           = "redis-commander-fooiy"
      awslogs_group      = aws_cloudwatch_log_group.prod_redis_commander_cloudwatch_log_group.name
      cpu                = 1024
      memory             = 2048
      redis_hosts        = "local:fooiy-api-redis.fooiy:6379"
  })
  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }

  depends_on = [aws_cloudwatch_log_group.prod_redis_commander_cloudwatch_log_group]
}
