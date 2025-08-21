resource "aws_lb" "this" {
  name               = "${terraform.workspace}-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.private_subnets

  enable_deletion_protection = false

  tags = {
    Name        = "${terraform.workspace}-ecs-alb"
    Environment = terraform.workspace
  }
}

resource "aws_lb_target_group" "this" {
  for_each = var.microservices

  name     = "${terraform.workspace}-${each.key}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/user"
    protocol            = "HTTP"
    matcher             = "200-404"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  lifecycle {
  create_before_destroy = true
  prevent_destroy       = false
  ignore_changes        = [name]
  }


  tags = {
    Environment = terraform.workspace
  
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default response"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "http" {
  for_each = var.microservices

  listener_arn = aws_lb_listener.http.arn

  priority = 1 + index(keys(var.microservices), each.key)

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }

  condition {
    path_pattern {
      values = ["/${each.key}*", "/${each.key}"]
    }
  }

  depends_on = [aws_lb_target_group.this]
}
