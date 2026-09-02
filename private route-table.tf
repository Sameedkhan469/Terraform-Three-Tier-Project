resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "frontend_1" {
  subnet_id      = aws_subnet.frontend_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "frontend_2" {
  subnet_id      = aws_subnet.frontend_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "backend_1" {
  subnet_id      = aws_subnet.backend_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "backend_2" {
  subnet_id      = aws_subnet.backend_2.id
  route_table_id = aws_route_table.private.id
}