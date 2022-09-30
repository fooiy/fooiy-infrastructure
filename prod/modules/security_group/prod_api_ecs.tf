# prod api ecs load_balancer 
resource "aws_security_group" "prod_api_load_balancer_security_group" {
  vpc_id = var.vpc_id
  name   = "prod_api_load_balancer_security_group"
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

  ingress {
    protocol    = "tcp"
    from_port   = 8081
    to_port     = 8081
    cidr_blocks = ["${data.aws_instance.vpn_ec2.public_ip}/32", var.office_ip] # vpn ip 
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_api_load_balancer_security_group"
  }

  depends_on = [data.aws_instance.vpn_ec2]
}

# prod api ecs task security group
resource "aws_security_group" "prod_api_ecs_task_security_group" {
  vpc_id = var.vpc_id
  name   = "prod_api_ecs_task_security_group"

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.prod_api_load_balancer_security_group.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_api_ecs_task_security_group"
  }
}

# prod redis commander ecs task security group
resource "aws_security_group" "prod_redis_commander_ecs_task_security_group" {
  vpc_id = var.vpc_id
  name   = "prod_redis_commander_ecs_task_security_group"

  ingress {
    protocol        = "tcp"
    from_port       = 8081
    to_port         = 8081
    security_groups = [aws_security_group.prod_api_load_balancer_security_group.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_redis_commander_ecs_task_security_group"
  }
}

resource "aws_security_group" "prod_api_redis_ecs_task_security_group" {
  name        = "prod_api_redis_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow all inbound traffic"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_api_ecs_task_security_group.id]
  }
  ingress {
    description     = "Allow all inbound traffic"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_redis_commander_ecs_task_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_api_redis_security_group"
  }
}


resource "aws_security_group" "prod_api_worker_ecs_task_security_group" {
  name        = "prod_api_worker_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow all inbound traffic"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_api_redis_ecs_task_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod_api_worker_security_group"
  }
}
