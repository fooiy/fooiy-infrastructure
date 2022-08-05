variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable vpn_ip {
  type        = string
  default     = "0.0.0.0/0"
  description = "vpn_ip"
}

