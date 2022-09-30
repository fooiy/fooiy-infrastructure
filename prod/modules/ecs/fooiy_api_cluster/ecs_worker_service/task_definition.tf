# 작업 정의
resource "aws_ecs_task_definition" "worker_task_definition" {
  family                   = "prod_worker_task_definition"
  network_mode             = "awsvpc"
  execution_role_arn       = var.ecs_task_execution_role_arn
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("modules/ecs/container_definition_command.json.tftpl",
    {
      region             = "ap-northeast-2"
      aws_ecr_repository = var.ecr_repository_url
      tag                = "latest"
      container_port     = 80
      host_port          = 80
      app_name           = "worker-fooiy"
      awslogs_group      = aws_cloudwatch_log_group.prod_api-worker_cloudwatch_log_group.name
      cpu                = 1024
      memory             = 2048
      command            = "celery"
  })
  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }

  depends_on = [aws_cloudwatch_log_group.prod_api-worker_cloudwatch_log_group]
}
