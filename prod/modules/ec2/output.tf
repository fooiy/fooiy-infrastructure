output "dev_api_ec2_ip"{
    value = aws_instance.dev_api_ec2.public_ip
}

output "prod_web_ec2_ip"{
    value = aws_instance.prod_web_ec2.public_ip
}

output "prod_web_ec2_id"{
    value = aws_instance.prod_web_ec2.id
}

output "prod_admin_ec2_ip"{
    value = aws_instance.prod_admin_ec2.public_ip
}
