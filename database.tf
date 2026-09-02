# ============================================================
# DATABASE SUBNET GROUP
# ============================================================

resource "aws_db_subnet_group" "database" {
  name = "three-tier-db-subnet-group"

  subnet_ids = [
    aws_subnet.db_1.id,
    aws_subnet.db_2.id
  ]

  tags = {
    Name = "three-tier-db-subnet-group"
  }
}

# ============================================================
# RDS MYSQL DATABASE
# ============================================================

resource "aws_db_instance" "mysql" {
  identifier = "three-tier-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 50

  db_name  = "threetierdb"
  username = "admin"
  password = "MySecurePass123!"

  db_subnet_group_name = aws_db_subnet_group.database.name

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0

  tags = {
    Name = "three-tier-mysql"
    Tier = "database"
  }
}