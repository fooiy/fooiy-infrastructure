resource "aws_security_group" "security_group_rds" {
  name        = "${var.vpc_name}-sg"
  vpc_id      = var.vpc_id

  ingress {
    # from 과 to 가 둘다 필요한 이유를 모르겠음
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol
    security_group_id = var.security_group_id
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-rds-sg"
  }
}