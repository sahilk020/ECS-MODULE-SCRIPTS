variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "alb_dns_name" {
  type = string
}

variable "alb_name" {
  type = string
}
variable "target_group_arn" {
  
}