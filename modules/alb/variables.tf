variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "lb_sg_ids" {
  description = "LoadBalancer SG ID"
  type        = list(string)
}

variable "lb_target_group_port" {
  description = "LB Target Group Port"
  type        = number # 80
}

variable "certificate_arn" {
  description = "Certificate ARN"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}
