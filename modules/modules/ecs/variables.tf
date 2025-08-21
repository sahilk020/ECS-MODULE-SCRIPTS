variable "name" {}
variable "image" {}
variable "container_port" {}
variable "log_group" {}
variable "target_group_arn" {}
variable "subnet_ids" {}
variable "security_group_ids" {}
variable "vpc_id" {}
variable "aws_region" {}
variable "task_role_arn" {}
variable "execution_role_arn" {}
variable "cpu" {
}
  
variable "memory"{
}
variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS service"
  type        = bool
}
variable "file_system_id" {
  type    = string
  default = null
}

variable "root_directory" {
  type    = string
  default = "/"
}

variable "transit_encryption" {
  type    = string
  default = "ENABLED"
}

variable "sourceVolume" {
  type    = string
  default = null
}

variable "containerPath" {
  type    = string
  default = null
}

variable "readOnly" {
  type    = bool
  default = false
}
