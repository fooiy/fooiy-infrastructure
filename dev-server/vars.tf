variable vpc_name {
    default = "fooiy"
}

variable vpc_cidr {
    default = "10.0.0.0/16"
}


variable private_subnet_cidr {
    default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable public_subnet_cidr {
    default = ["10.0.1.0/24"]
}

variable subnet_az {
    default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
}

variable instance_type {
    default = "t2.micro"
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
data "aws_key_pair" "fooiy-web-key" {
  key_name = "fooiy-web"
}

variable rds_allocated_storage   {
    default = 10 
}
variable rds_engine              {
    default = "mysql" 
}
variable rds_engine_version      {
    default = "5.7" 
}
variable rds_instance_class      {
    default = "db.t2.micro" 
}
variable rds_name                {
    default = "fooiydev" 
}
variable rds_username            {
    default = "admin" 
}
variable rds_password            {
    default = "foobarbaz" 
}
variable rds_parameter_group_name{
    default = "default.mysql5.7" 
}
variable rds_skip_final_snapshot {
    default = true 
}
