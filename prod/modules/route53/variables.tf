variable "dev_api_ec2_ip" {
  description = "dev api ec2 ip"
  type        = list(string)
}

variable "prod_admin_ec2_ip" {
  description = "prod admin ec2 ip"
  type        = list(string)
}

variable "prod_web_load_balancer_dns_name" {
  description = "prod_web_load_balancer_dns_name"
  type        = string
}

variable "prod_web_load_balancer_zone_id" {
  description = "prod_web_load_balancer_zone_id"
  type        = string
}

variable "prod_api_load_balancer_dns_name" {
  description = "prod_api_load_balancer_dns_name"
  type        = string
}

variable "prod_api_load_balancer_zone_id" {
  description = "prod_api_load_balancer_zone_id"
  type        = string
}
