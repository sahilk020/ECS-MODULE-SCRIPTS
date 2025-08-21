data "dns_a_record_set" "alb_ips" {
  host = var.alb_dns_name
}


resource "aws_lb" "nlb" {
  name               = "${terraform.workspace}-public-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets   # ✅ MUST be set

  enable_cross_zone_load_balancing = true
}
resource "aws_lb_target_group" "nlb_to_alb" {
  name        = "${terraform.workspace}-ecs-nlb-to-alb"
  port        = 80
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id


  health_check {
    protocol = "TCP"
    port     = "80"
  }
}
resource "aws_lb_target_group_attachment" "alb_ip_targets" {
  target_group_arn = var.target_group_arn
  target_id        = data.dns_a_record_set.alb_ips.addrs[0]  # Only first IP
  port             = 80
}           
# resource "aws_lb_target_group_attachment" "alb_ip_target_2" {
#   target_group_arn = var.target_group_arn
#   target_id        = data.dns_a_record_set.alb_ips.addrs[1]
#   port             = 80
# }
# resource "aws_lb_target_group_attachment" "alb_ip_target_3" {
#   target_group_arn = var.target_group_arn
#   target_id        = data.dns_a_record_set.alb_ips.addrs[2]
#   port             = 80
# }

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_to_alb.arn  # ✅ use fixed TG
  }
}
