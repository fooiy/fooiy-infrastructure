# ecs 작업 실행 규칙 생성
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 작업 정의
resource "aws_ecs_task_definition" "api_task_definition" {
  family                   = "api-fooiy"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions    = templatefile("modules/ecs/container_definition.json.tftpl", 
    {
    region             = "ap-northeast-2"
    aws_ecr_repository = var.ecr_repository_url
    tag                = "latest"
    container_port     = 80
    host_port          = 80
    app_name           = "api-fooiy"
    awslogs_group      = aws_cloudwatch_log_group.prod_api_cloudwatch_log_group.name
  })
  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }

  depends_on = [aws_cloudwatch_log_group.prod_api_cloudwatch_log_group]
}

resource "aws_ecs_cluster" "fooiy-api" {
  name = "fooiy-api"
}

resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.fooiy-api.id
  task_definition = aws_ecs_task_definition.api_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
 
  network_configuration {
    security_groups  = var.security_groups 
    subnets          = var.subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "api-fooiy"
    container_port   = 80
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]

  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }
}

resource "aws_s3_bucket" "prod_api_log_storage" {
  bucket = "prod-api-log-storage"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::033677994240:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::prod-api-log-storage/*"
      }
    ]
  })
  
  lifecycle_rule {
    id      = "log_lifecycle"
    prefix  = ""
    enabled = true

    expiration {
      days = 10
    }
  }

  force_destroy = true
}


resource "aws_cloudwatch_log_group" "prod_api_cloudwatch_log_group" {
  name = "/aws/ecs/api"

  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }
}