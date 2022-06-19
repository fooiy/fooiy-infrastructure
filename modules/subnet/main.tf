# subnet 리소스
resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = var.subnet_az
  map_public_ip_on_launch = var.is_public

  tags = {
    Name = "${var.vpc_name}-${var.public_or_private[var.is_public]}-subnet"
  }
}
