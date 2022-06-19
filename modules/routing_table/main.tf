resource "aws_route_table" "public_routing_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${vpc_name}-public-routing-table"
  }
}

resource "aws_route_table_association" "public_routing_table" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.public_routing_table.id
}


resource "aws_route_table" "private_routing_table" {
  vpc_id = var.vpc_id

  # route 없는거 테스트

  tags = {
    Name = "${vpc_name}-public-routing-table"
  }
}

resource "aws_route_table_association" "private_routing_table" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.private_routing_table.id
}
