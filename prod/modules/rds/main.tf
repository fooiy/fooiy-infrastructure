resource "aws_db_instance" "dev_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  db_name              = "dev_rds"
  identifier           = "dev-rds"
  username             = "admin"
  password             = "mh76y4rL52UryqdE3kBa"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = var.allowed_security_groups
  db_subnet_group_name = var.db_subnet_group_name
}


   
  



# module "dev_rds" {
#   source  = "terraform-aws-modules/rds-aurora/aws"

#   name           = "dev_rds"
#   engine         = "aurora-mysql"
#   engine_version = "5.7"
#   instance_class = "db.r6g.large"
#   instances = {
#     one = {}
#   }

#   vpc_id  = var.vpc_id
#   subnets = var.subnets

#   allowed_security_groups = var.allowed_security_groups
#   allowed_cidr_blocks     = ["0.0.0.0/20"]

#   storage_encrypted   = true
#   apply_immediately   = true
#   monitoring_interval = 60

#   db_parameter_group_name         = "default"
#   db_cluster_parameter_group_name = "default"

#   enabled_cloudwatch_logs_exports = ["mysql"]

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }