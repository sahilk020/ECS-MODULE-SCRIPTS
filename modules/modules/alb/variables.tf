variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "microservices" {
  description = "Map of microservices with their configs"
  type        = map(any)
}