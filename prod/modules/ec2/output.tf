output "dev_api_ec2_ip"{
    value = aws_instance.dev_api_ec2.public_ip
}