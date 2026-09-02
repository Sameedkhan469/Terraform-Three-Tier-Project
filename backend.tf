# ============================================================
# BACKEND EC2 INSTANCE 1
# ============================================================

resource "aws_instance" "backend_1" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.backend_1.id

  vpc_security_group_ids = [
    aws_security_group.backend.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install python3 -y

              echo "Backend Server 1" > /tmp/backend.txt
              EOF

  tags = {
    Name = "backend-server-1"
    Tier = "backend"
  }
}

# ============================================================
# BACKEND EC2 INSTANCE 2
# ============================================================

resource "aws_instance" "backend_2" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.backend_2.id

  vpc_security_group_ids = [
    aws_security_group.backend.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install python3 -y

              echo "Backend Server 2" > /tmp/backend.txt
              EOF

  tags = {
    Name = "backend-server-2"
    Tier = "backend"
  }
}