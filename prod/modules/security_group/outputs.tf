output "dev_api_ec2_security_group_id" {
  value = aws_security_group.dev_api_ec2_security_group.id
}

output "prod_web_ec2_security_group_id" {
  value = aws_security_group.prod_web_ec2_security_group.id
}

output "prod_admin_ec2_security_group_id" {
  value = aws_security_group.prod_admin_ec2_security_group.id
}

output "vpn_ec2_security_group_id" {
  value = aws_security_group.vpn_ec2_security_group.id
}

output prod_api_ecs_task_security_group_id{
value = aws_security_group.prod_api_ecs_task_security_group.id
}
output prod_api_loadbalancer_security_group_id{
value = aws_security_group.prod_api_loadbalancer_security_group.id
}

output prod_web_loadbalancer_security_group_id {
  value       = aws_security_group.prod_web_loadbalancer_security_group.id
  sensitive   = true
  description = "description"
  depends_on  = []
}
