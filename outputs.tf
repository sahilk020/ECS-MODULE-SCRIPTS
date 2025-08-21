output "ecs_service_names" {
  value = {
    for svc, mod in module.ecs :
    svc => mod.service_name
  }
}

output "ecs_service_arns" {
  value = {
    for svc, mod in module.ecs :
    svc => mod.service_arn
  }
}
