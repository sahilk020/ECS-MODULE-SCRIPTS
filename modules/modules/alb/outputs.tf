output "alb_arn" {
  value = aws_lb.this.arn
}

output "target_group_arn" {
  value = {
    for svc in keys(var.microservices) :
    svc => aws_lb_target_group.this[svc].arn
  }
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}
