locals {
  microservices = {
    authorizer = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/authorizer:latest"
      container_port = 9093
      log_group      = "/ecs/${terraform.workspace}/authorizer"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    grievance = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/grievance:latest"
      container_port = 8090
      log_group      = "/ecs/${terraform.workspace}/grievance"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    mocrm = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/mocrm:latest"
      container_port = 9091
      log_group      = "/ecs/${terraform.workspace}/mocrm"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    notification = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/notification:latest"
      container_port = 8096
      log_group      = "/ecs/${terraform.workspace}/notification"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    openbanking = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/openbanking:latest"
      container_port = 7060
      log_group      = "/ecs/${terraform.workspace}/openbanking"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    product = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/product:latest"
      container_port = 8086
      log_group      = "/ecs/${terraform.workspace}/product"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    scheduler = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/scheduler:latest"
      container_port = 8098
      log_group      = "/ecs/${terraform.workspace}/scheduler"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    transaction = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/transaction:latest"
      container_port = 8083
      log_group      = "/ecs/${terraform.workspace}/transaction"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }

    user = {
      image          = "878178633070.dkr.ecr.ap-south-1.amazonaws.com/prod/user:latest"
      container_port = 8082
      log_group      = "/ecs/${terraform.workspace}/user"
      file_system_id     = "fs-003f4221707146efd"
      root_directory     = "/"
      transit_encryption = "ENABLED"
      sourceVolume  = "efs-volume"
      containerPath = "/app/icon/"
      readOnly      = false
    }
  }
}
