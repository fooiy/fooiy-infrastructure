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


# 퍼블릭 라우팅테이블 리소스
resource "aws_route_table" "public_routing_table" {
  count = var.is_public
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.vpc_name}-public_routing-table"
  }
}
resource "aws_route_table_association" "public_routing_table" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public_routing_table.id
}


# 프라이빗 라우팅테이블 리소스
resource "aws_route_table" "private_routing_table" {
  count = 1 - var.is_public
  vpc_id = var.vpc_id

  # 로컬 되는지 확인할 것

  tags = {
    Name = "${var.vpc_name}-private_routing-table"
  }
}
resource "aws_route_table_association" "private_routing_table" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.private_routing_table.id
}
