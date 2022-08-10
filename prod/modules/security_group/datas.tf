data "aws_instance" "vpn_ec2" {
  filter {
    name   = "tag:Name"
    values = ["vpn_ec2"]
  }
}
