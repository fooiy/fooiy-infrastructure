variable "cluster_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_groups" {
  type        = list(string)
  description = "security_groups"
}

variable "subnets" {
  type        = list(string)
  description = "subnets"
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_service_discovery_zone_id" {
  type = string
}
