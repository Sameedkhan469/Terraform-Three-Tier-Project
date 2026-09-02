# ============================================================
# DATABASE ROUTE TABLE
# ============================================================

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "database-route-table"
  }
}

# ============================================================
# DATABASE SUBNET 1 ASSOCIATION
# ============================================================

resource "aws_route_table_association" "db_1" {
  subnet_id      = aws_subnet.db_1.id
  route_table_id = aws_route_table.database.id
}

# ============================================================
# DATABASE SUBNET 2 ASSOCIATION
# ============================================================

resource "aws_route_table_association" "db_2" {
  subnet_id      = aws_subnet.db_2.id
  route_table_id = aws_route_table.database.id
}