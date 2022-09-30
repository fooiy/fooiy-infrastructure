resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "fooiy_api_cluster" {
  source = "./fooiy_api_cluster"

  ecs_task_execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  ecr_repository_url               = var.fooiy_api_ecr_repository_url
  api_security_groups              = var.fooiy_api_api_security_groups
  redis_security_groups            = var.fooiy_api_redis_security_groups
  redis_commander_security_groups  = var.fooiy_api_redis_commander_security_groups
  worker_security_groups           = var.fooiy_api_worker_security_groups
  subnets                          = var.fooiy_api_subnets
  api_target_group_arn             = var.fooiy_api_prod_api_target_group_arn
  redis_commander_target_group_arn = var.fooiy_api_redis_commander_target_group_arn
  vpc_id                           = var.vpc_id
}
