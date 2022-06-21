variable vpc_name {
    default = "fooiy-dev"
}

variable vpc_cidr {
    default = "10.0.0.0/16"
}

variable public_subnet_cidr {
    default = ["10.0.1.0/24"]
}

variable subnet_az {
    default = "ap-northeast-2a"
}

variable ec2_from_port {
    default = 80
}
variable ec2_to_port {
    default = 80
}
variable ec2_protocol {
    default = "tcp"
}
variable ec2_sg_cidr_block {
    default = "0.0.0.0/0"
}

variable instance_type {
    default = "t2.micro"
}
variable ec2_usage {
    default = "dev-api"
}

variable rds_from_port {
    default = 22
}
variable rds_to_port {
    default = 22
}
variable rds_protocol {
    default = "ssh"
}


# 우분투 이미지
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "fooiy-dev-key" {
  key_name = "fooiy-dev"
}
