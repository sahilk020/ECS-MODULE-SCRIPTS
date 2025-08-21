locals {
  microservices = {
    auth = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/auth:latest"
      container_port = 8080
      log_group      = "/ecs/${terraform.workspace}/auth"
    }

    grievance = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/grievance:latest"
      container_port = 8090
      log_group      = "/ecs/${terraform.workspace}/grievance"
    }

    mocrm = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/mocrm:latest"
      container_port = 8082
      log_group      = "/ecs/${terraform.workspace}/mocrm"
    }

    notification = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/notification:latest"
      container_port = 8096
      log_group      = "/ecs/${terraform.workspace}/notification"
    }

    openbanking = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/openbanking:latest"
      container_port = 7060
      log_group      = "/ecs/${terraform.workspace}/openbanking"
    }

    product = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/product:latest"
      container_port = 8085
      log_group      = "/ecs/${terraform.workspace}/product"
    }

    scheduler = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/scheduler:latest"
      container_port = 8086
      log_group      = "/ecs/${terraform.workspace}/scheduler"
    }

    transaction = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/transaction:latest"
      container_port = 8087
      log_group      = "/ecs/${terraform.workspace}/transaction"
    }

    user = {
      image          = "484907490372.dkr.ecr.ap-south-1.amazonaws.com/preprod/user:latest"
      container_port = 8088
      log_group      = "/ecs/${terraform.workspace}/user"
    }
  }
}
