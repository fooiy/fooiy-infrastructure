variable application_load_balancer_name {
  type        = string
  default     = ""
  description = "application_load_balancer_name"
}

variable load_balancer_target_group_name {
  type        = string
  default     = ""
  description = "load_balancer_target_group_name"
}

variable aws_lb_listener_rule_host_value {
  type        = string
  default     = ""
  description = "aws_lb_listener_rule_host_value"
}

variable "security_groups" {
  description = "security group ids"
  type        = list(string)
}

variable "subnets" {
  description = "subnets ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable health_check_path {
  type        = string
  default     = ""
  description = "health_check_path"
}

variable target_type {
  type        = string
  default     = "instance"
  description = "target_type"
}


data "aws_acm_certificate" "fooiy_certification" {
  domain   = "*.fooiy.com"
}