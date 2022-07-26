resource "aws_route_table" "dev_public_subnet_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "dev_public_subnet_route_table"
  }
}
resource "aws_route_table_association" "dev_public_subnet_a_route_table" {
  subnet_id      = var.subnet_public_a_id
  route_table_id = aws_route_table.dev_public_subnet_route_table.id
}
resource "aws_route_table_association" "dev_public_subnet_c_route_table" {
  subnet_id      = var.subnet_public_c_id
  route_table_id = aws_route_table.dev_public_subnet_route_table.id
}


resource "aws_route_table" "dev_private_subnet_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dev_private_subnet_route_table"
  }
}
resource "aws_route_table_association" "dev_private_subnet_a_route_table" {
  subnet_id      = var.subnet_private_a_id
  route_table_id = aws_route_table.dev_private_subnet_route_table.id
}
resource "aws_route_table_association" "dev_private_subnet_c_route_table" {
  subnet_id      = var.subnet_private_c_id
  route_table_id = aws_route_table.dev_private_subnet_route_table.id
}
