variable "fooiy_api_ecr_repository_url" {
  type        = string
  default     = ""
  description = "ecr_repository_url"
}

variable "fooiy_api_api_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "fooiy_api_redis_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "fooiy_api_redis_commander_security_groups" {
  type        = list(string)
  description = "security_groups"
}
variable "fooiy_api_worker_security_groups" {
  type        = list(string)
  description = "security_groups"
}

variable "fooiy_api_subnets" {
  type        = list(string)
  description = "subnets"
}

variable "fooiy_api_prod_api_target_group_arn" {
  type        = string
  description = "target_group_arn"
}
variable "fooiy_api_redis_commander_target_group_arn" {
  type        = string
  description = "target_group_arn"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

