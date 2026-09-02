# ============================================================
# FRONTEND EC2 INSTANCE 1
# ============================================================

resource "aws_instance" "frontend_1" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  subnet_id = aws_subnet.frontend_1.id

  vpc_security_group_ids = [
    aws_security_group.frontend.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Frontend Server 1</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "frontend-server-1"
    Tier = "frontend"
  }
}

# ============================================================
# FRONTEND EC2 INSTANCE 2
# ============================================================

resource "aws_instance" "frontend_2" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = var.instance_type

  subnet_id = aws_subnet.frontend_2.id

  vpc_security_group_ids = [
    aws_security_group.frontend.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Frontend Server 2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "frontend-server-2"
    Tier = "frontend"
  }
}

# ============================================================
# TARGET GROUP ATTACHMENT - FRONTEND 1
# ============================================================

resource "aws_lb_target_group_attachment" "frontend_1" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.frontend_1.id
  port             = 80
}

# ============================================================
# TARGET GROUP ATTACHMENT - FRONTEND 2
# ============================================================

resource "aws_lb_target_group_attachment" "frontend_2" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.frontend_2.id
  port             = 80
}