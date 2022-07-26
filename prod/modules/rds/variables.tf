variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "subnets" {
  description = "rds subnets"
  type        = list(string)
}

variable "allowed_security_groups" {
  description = "rds allowed_security_groups"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "db_subnet_group_name"
  type        = string
}
