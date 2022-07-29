variable "vpc_dev_api_security_group_ids" {
  description = "vpc security group ids"
  type        = list(string)
}
variable "vpc_prod_web_security_group_ids" {
  description = "vpc security group ids"
  type        = list(string)
}
variable "vpc_prod_admin_security_group_ids" {
  description = "vpc security group ids"
  type        = list(string)
}
variable "vpc_vpn_security_group_ids" {
  description = "vpc security group ids"
  type        = list(string)
}

variable "availability_zones" {
  description = "availability zones"
  type = object({
    a = string
    b = string
    c = string
    d = string
  })
}

variable "subnet_a_id" {
  description = "subnet a id"
  type        = string
}

variable "subnet_c_id" {
  description = "subnet c id"
  type        = string
}

