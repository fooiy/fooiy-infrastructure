variable "cluster_id" {
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

variable "target_group_arn" {
  type        = string
  default     = ""
  description = "target_group_arn"
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecr_repository_url" {
  type        = string
  default     = ""
  description = "ecr_repository_url"
}
