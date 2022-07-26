resource "aws_instance" "dev_api_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" # Free Tier eligible
  key_name               = data.aws_key_pair.dev_api_key_pair.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.availability_zones.a
  subnet_id              = var.subnet_id
  # user_data              = file("./init-script.sh")

  root_block_device {
    volume_size = 30 # Free Tier eligible
  }

  tags = {
    Name = "dev_api_ec2"
  }
}

# resource "aws_instance" "ec2" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t2.micro" # Free Tier eligible
#   key_name               = "prod-web-key-pair"
#   vpc_security_group_ids = var.vpc_security_group_ids
#   availability_zone      = var.availability_zones.a
#   subnet_id              = var.subnet_id
#   # user_data              = file("./init-script.sh")

#   root_block_device {
#     volume_size = 30 # Free Tier eligible
#   }

#   tags = {
#     Name = "prod_web_ec2"
#   }
# }
