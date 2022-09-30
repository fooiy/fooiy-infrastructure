variable "ecr_repository_url" {
  type        = string
  default     = ""
  description = "ecr_repository_url"
}

variable "api_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "redis_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "redis_commander_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "worker_security_groups" {
  type        = list(string)
  description = "security_groups"
}


variable "subnets" {
  type        = list(string)
  description = "subnets"
}

variable "api_target_group_arn" {
  type        = string
  default     = ""
  description = "target_group_arn"
}
variable "redis_commander_target_group_arn" {
  type        = string
  default     = ""
  description = "target_group_arn"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

variable "ecs_task_execution_role_arn" {
  type = string
}
