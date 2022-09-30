# ecs 작업 실행 규칙 생성
resource "aws_service_discovery_private_dns_namespace" "ecs_service_discovery_zone" {
  name        = "fooiy"
  vpc         = var.vpc_id
  description = "ecs service discovery zone"
}

resource "aws_ecs_cluster" "fooiy-api" {
  name = "fooiy-api"
}

module "ecs_api_service" {
  source = "./ecs_api_service"

  cluster_id                  = aws_ecs_cluster.fooiy-api.id
  security_groups             = var.api_security_groups
  subnets                     = var.subnets
  target_group_arn            = var.api_target_group_arn
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
  ecr_repository_url          = var.ecr_repository_url
}

module "ecs_redis_commander_service" {
  source = "./ecs_redis_commander_service"

  cluster_id                  = aws_ecs_cluster.fooiy-api.id
  security_groups             = var.redis_commander_security_groups
  subnets                     = var.subnets
  target_group_arn            = var.redis_commander_target_group_arn
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
}

module "ecs_reids_service" {
  source = "./ecs_redis_service"

  vpc_id                        = var.vpc_id
  cluster_id                    = aws_ecs_cluster.fooiy-api.id
  security_groups               = var.redis_security_groups
  subnets                       = var.subnets
  ecs_task_execution_role_arn   = var.ecs_task_execution_role_arn
  ecs_service_discovery_zone_id = aws_service_discovery_private_dns_namespace.ecs_service_discovery_zone.id

  depends_on = [
    aws_service_discovery_private_dns_namespace.ecs_service_discovery_zone
  ]
}

module "ecs_worker_service" {
  source = "./ecs_worker_service"

  cluster_id                  = aws_ecs_cluster.fooiy-api.id
  security_groups             = var.worker_security_groups
  subnets                     = var.subnets
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
  ecr_repository_url          = var.ecr_repository_url
}
