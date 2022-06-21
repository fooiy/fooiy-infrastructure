variable vpc_id {}
variable subnet_cidr {}
variable subnet_az {}
variable is_public {}
variable vpc_name {}
variable igw_id {}

variable public_or_private {
    type = map(any)
    default = {
        true = "public"
        false = "private"
    }
}
