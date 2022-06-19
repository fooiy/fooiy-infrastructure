resource "aws_instance" "ec2" {
  ami           = var.images
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_ids]
  subnet_id = var.subnet_id

  tags = {
    Name = "${var.vpc_name}-${var.ec2_usage}-ec2"
  }
}