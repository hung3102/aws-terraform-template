variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "api_lb_arn" {
  description = "ARN of the API Load Balancer"
  type        = string
}

variable "admin_allowed_ips" {
  description = "List of IPs allowed to access the admin panel"
  type        = list(string)
}
