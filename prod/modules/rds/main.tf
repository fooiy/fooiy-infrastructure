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
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_group_name

  deletion_protection = true
}


# module "prod_rds" {
#   source  = "terraform-aws-modules/rds-aurora/aws"

#   name           = "prod-rds"
#   engine         = "aurora-mysql"
#   engine_version = "5.7"
#   instances = {
#     1 = {
#       instance_class      = "db.r5.large"
#       publicly_accessible = true
#     }
#     2 = {
#       identifier     = "mysql-static-1"
#       instance_class = "db.r5.2xlarge"
#     }
#     3 = {
#       identifier     = "mysql-excluded-1"
#       instance_class = "db.r5.xlarge"
#       promotion_tier = 15
#     }
#   }

#   vpc_id  = var.vpc_id
#   # db_subnet_group_name = var.db_subnet_group_name
#   subnets = var.subnets

#   allowed_security_groups = var.allowed_security_groups
#   allowed_cidr_blocks     = ["0.0.0.0/20"]

#   iam_database_authentication_enabled = true
#   master_password                     = "1234567890"
#   create_random_password              = false

#   storage_encrypted   = true
#   apply_immediately   = true
#   skip_final_snapshot = true
#   monitoring_interval = 60

#   db_parameter_group_name         = aws_db_parameter_group.example.id
#   db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example.id

#   enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

#   tags = {
#     Environment = "prod"
#     Terraform   = "true"
#   }
# }

# resource "aws_db_parameter_group" "example" {
#   name        = "aurora-db-57-parameter-group"
#   family      = "aurora-mysql5.7"
#   description = "aurora-db-57-parameter-group"
# }

# resource "aws_rds_cluster_parameter_group" "example" {
#   name        = "aurora-57-cluster-parameter-group"
#   family      = "aurora-mysql5.7"
#   description = "aurora-57-cluster-parameter-group"
# }
