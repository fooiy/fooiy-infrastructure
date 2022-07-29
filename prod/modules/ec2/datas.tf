data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # Ubuntu Server 20.04
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "dev_api_key_pair" {
  key_name           = "dev-api-key-pair"
}

data "aws_key_pair" "prod_web_key_pair" {
  key_name           = "prod-web-key-pair"
}

data "aws_key_pair" "prod_admin_key_pair" {
  key_name           = "prod-admin-key-pair"
}

data "aws_key_pair" "vpn_key_pair" {
  key_name           = "vpn-key-pair"
}