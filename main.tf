module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${terraform.workspace}-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
module "alb" {
  source             = "./modules/modules/alb"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  security_group_ids = [aws_security_group.ecs_ssg.id]
  microservices  = local.microservices
}

module "ecs" {
  source         = "./modules/modules/ecs"
  for_each = local.microservices
  aws_region     = var.aws_region
  
  cpu            = 4096
  memory         = 8192
  container_port = each.value.container_port
  name               = each.key
  image              = each.value.image
  log_group          = each.value.log_group
  vpc_id           = module.vpc.vpc_id
  desired_count = 1
  assign_public_ip = false

  subnet_ids         = module.vpc.private_subnets
  target_group_arn   = module.alb.target_group_arn[each.key]

  security_group_ids = [aws_security_group.ecs_ssg.id]

  task_role_arn      = "arn:aws:iam::878178633070:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::878178633070:role/ecsTaskExecutionRole"
  file_system_id     = try(each.value.file_system_id, null)
  root_directory     = try(each.value.root_directory, null)
  transit_encryption = try(each.value.transit_encryption, null)
  sourceVolume       = try(each.value.sourceVolume, null)
  containerPath      = try(each.value.containerPath, null)

}
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  for_each = local.microservices
  name              = each.value.log_group
  retention_in_days = 30
}
resource "aws_security_group" "ecs_ssg" {
  name        = "${terraform.workspace}-ecs-ssg"
  description = "Security group for ECS tasks"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Or your specific CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = terraform.workspace
  }
}
#  module "nlb" {
#    source = "./modules/modules/nlb"
#    vpc_id         = module.vpc.vpc_id
#    public_subnets = module.vpc.public_subnets
#    target_group_arn = module.alb.target_group_arn

#    alb_dns_name   = module.alb.alb_dns_name   # output from alb module
#    alb_name       = module.alb.alb_name       # output from alb module
# }


