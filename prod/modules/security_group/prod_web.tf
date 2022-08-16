# prod api ecs load_balancer 
resource "aws_security_group" "prod_web_load_balancer_security_group" {
  vpc_id = var.vpc_id
  name   = "prod_web_load_balancer_security_group"
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_web_load_balancer_security_group"
  }
}

# prod web ec2
resource "aws_security_group" "prod_web_ec2_security_group" {
  name        = "prod_web_ec2_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_instance.vpn_ec2.public_ip}/32"]
  }
  ingress {
    description     = "Allow all inbound traffic"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_web_load_balancer_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_web_ec2_security_group"
  }

  depends_on = [data.aws_instance.vpn_ec2]
}
