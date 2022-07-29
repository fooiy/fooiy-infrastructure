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


variable "prod_web_instance_id"{
  description = "prod_web_instance_id"
  type = string
}

data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}