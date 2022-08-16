# prod admin ec2
resource "aws_security_group" "prod_admin_ec2_security_group" {
  name        = "prod_admin_ec2_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_instance.vpn_ec2.public_ip}/32", "13.124.207.221/32"]
  }
  ingress {
    description = "Allow all inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_instance.vpn_ec2.public_ip}/32"]
  }
  ingress {
    description = "Allow all inbound traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_instance.vpn_ec2.public_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_admin_ec2_security_group"
  }
  depends_on = [data.aws_instance.vpn_ec2]
}
