terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}



# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${terraform.workspace}-cluster"
}

# ECS Capacity Providers
resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}



# ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${terraform.workspace}-${var.name}"
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  dynamic "volume" {
    for_each = var.file_system_id != null ? [1] : []
    content {
      name = var.sourceVolume

      efs_volume_configuration {
        file_system_id     = var.file_system_id
        root_directory     = var.root_directory
        transit_encryption = var.transit_encryption
      }
    }
  }

  container_definitions = jsonencode([
    {
      name      = "${terraform.workspace}-${var.name}"  # <-- FIXED: container name matches ECS expectations
      image     = var.image
      cpu       = var.cpu
      memory    = var.memory
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.name
        }
      }

      mountPoints = var.file_system_id != null ? [
        {
          sourceVolume  = var.sourceVolume
          containerPath = var.containerPath
          readOnly      = var.readOnly
        }
      ] : []
    }
  ])
}


# ECS Service
resource "aws_ecs_service" "ecs_service" {
  name            = "${terraform.workspace}-${var.name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = false

  }
  lifecycle {
  create_before_destroy = false
  ignore_changes = [desired_count]
  }

  deployment_controller {
    type = "ECS"
  }
  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${terraform.workspace}-${var.name}"
    container_port   = var.container_port
  }

}
