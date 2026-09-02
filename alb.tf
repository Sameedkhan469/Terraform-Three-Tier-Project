# ============================================================
# FRONTEND TARGET GROUP
# ============================================================

resource "aws_lb_target_group" "frontend" {
  name     = "three-tier-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "three-tier-frontend-tg"
  }
}

# ============================================================
# APPLICATION LOAD BALANCER
# ============================================================

resource "aws_lb" "main" {
  name               = "three-tier-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.lb.id
  ]

  subnets = [
    aws_subnet.lb_1.id,
    aws_subnet.lb_2.id
  ]

  tags = {
    Name = "three-tier-alb"
  }
}

# ============================================================
# ALB HTTP LISTENER
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}