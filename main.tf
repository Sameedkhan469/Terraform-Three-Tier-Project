resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "three-tier-vpc"
  }
}
# -------------------------
# LOAD BALANCER SUBNETS
# -------------------------

resource "aws_subnet" "lb_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "lb-public-subnet-1"
    Tier = "load-balancer"
  }
}

resource "aws_subnet" "lb_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "lb-public-subnet-2"
    Tier = "load-balancer"
  }
}


# -------------------------
# FRONTEND SUBNETS
# -------------------------

resource "aws_subnet" "frontend_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "frontend-private-subnet-1"
    Tier = "frontend"
  }
}

resource "aws_subnet" "frontend_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "frontend-private-subnet-2"
    Tier = "frontend"
  }
}


# -------------------------
# BACKEND SUBNETS
# -------------------------

resource "aws_subnet" "backend_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "backend-private-subnet-1"
    Tier = "backend"
  }
}

resource "aws_subnet" "backend_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "backend-private-subnet-2"
    Tier = "backend"
  }
}


# -------------------------
# DATABASE SUBNETS
# -------------------------

resource "aws_subnet" "db_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.31.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "db-private-subnet-1"
    Tier = "database"
  }
}

resource "aws_subnet" "db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "db-private-subnet-2"
    Tier = "database"
  }
}