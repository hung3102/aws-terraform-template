variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "Codedeploy Role ARN"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "lb_listener_arn" {
  description = "LB Listener ARN"
  type        = string
}

variable "lb_blue_target_group_name" {
  description = "LB Blue Target Group Name"
  type        = string
}

variable "lb_green_target_group_name" {
  description = "LB Green Target Group Name"
  type        = string
}
