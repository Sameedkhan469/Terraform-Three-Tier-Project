# ============================================================
# LOAD BALANCER SECURITY GROUP
# ============================================================

resource "aws_security_group" "lb" {
  name        = "three-tier-lb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP from Internet
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from Internet
  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three-tier-lb-sg"
  }
}


# ============================================================
# FRONTEND SECURITY GROUP
# ============================================================

resource "aws_security_group" "frontend" {
  name        = "three-tier-frontend-sg"
  description = "Security group for Frontend servers"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP only from Load Balancer
  ingress {
    description     = "HTTP from Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three-tier-frontend-sg"
  }
}
# ============================================================
# BACKEND SECURITY GROUP
# ============================================================

resource "aws_security_group" "backend" {
  name        = "three-tier-backend-sg"
  description = "Security group for Backend servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Backend traffic from Frontend"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three-tier-backend-sg"
  }
}

# ============================================================
# DATABASE SECURITY GROUP
# ============================================================

resource "aws_security_group" "database" {
  name        = "three-tier-database-sg"
  description = "Security group for Database"
  vpc_id      = aws_vpc.main.id

  # Allow MySQL only from Backend
  ingress {
    description     = "MySQL from Backend"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three-tier-database-sg"
  }
}