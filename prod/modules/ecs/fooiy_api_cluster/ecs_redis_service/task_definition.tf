# 작업 정의
resource "aws_ecs_task_definition" "api_redis_task_definition" {
  family                   = "prod_api_redis_task_definition"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_execution_role_arn
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("modules/ecs/container_definition.json.tftpl",
    {
      region             = "ap-northeast-2"
      aws_ecr_repository = "redis"
      tag                = "latest"
      container_port     = 80
      host_port          = 80
      app_name           = "redis-fooiy"
      awslogs_group      = aws_cloudwatch_log_group.prod_api-redis_cloudwatch_log_group.name
      cpu                = 1024
      memory             = 2048
  })
  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }

  depends_on = [aws_cloudwatch_log_group.prod_api-redis_cloudwatch_log_group]
}
