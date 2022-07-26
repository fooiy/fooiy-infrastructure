resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dev_internet_gateway"
  }
}
