variable "prod_web_security_groups" {
  description = "security group ids"
  type        = list(string)
}

variable "prod_web_subnets" {
  description = "subnets ids"
  type        = list(string)
}

variable "prod_api_security_groups" {
  description = "security group ids"
  type        = list(string)
}

variable "prod_api_subnets" {
  description = "subnets ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "prod_web_instance_id"{
  description = "prod_web_instance_id"
  type = string
}

