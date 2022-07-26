output "subnet_public_a_id" {
  value = module.subnet_public_a.id
}

output "subnet_public_c_id" {
  value = module.subnet_public_c.id
}

output "subnet_private_a_id" {
  value = module.subnet_private_a.id
}

output "subnet_private_c_id" {
  value = module.subnet_private_c.id
}

output "private_subnet_group_name" {
  value = aws_db_subnet_group.private_subnet_group.name
}