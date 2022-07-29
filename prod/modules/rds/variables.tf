variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "subnets" {
  description = "rds subnets"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "rds vpc_security_group_ids"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "db_subnet_group_name"
  type        = string
}
