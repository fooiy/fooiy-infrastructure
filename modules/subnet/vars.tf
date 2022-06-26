variable vpc_id {}
variable subnet_cidr {}
variable subnet_az {}
variable is_public {}
variable vpc_name {}
variable igw_id {}
variable subnet_usage {}

variable public_or_private {
    type = map(any)
    default = {
        true = "public"
        false = "private"
    }
}

variable change_value_to_int {
    type = map(any)
    default = {
        true = 1
        false = 0
    }
}