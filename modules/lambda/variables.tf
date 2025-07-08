variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the Lambda Execution Role"
  type        = string
}

variable "scheduler_secret_token" {
  description = "Secret token for the Scheduler"
  type        = string
}

variable "api_base_url" {
  description = "Base URL of the API"
  type        = string
}
