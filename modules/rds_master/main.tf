resource "aws_db_instance" "rds" {
  identifier           = var.rds_name
  allocated_storage    = var.rds_allocated_storage
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  db_name              = var.rds_name
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = var.rds_skip_final_snapshot
  vpc_security_group_ids = var.rds_vpc_security_group_ids 
  db_subnet_group_name = var.db_subnet_group_name
  replica_mode = "open-read-only"
}