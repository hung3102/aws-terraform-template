variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "update_application_statuses_lambda_arn" {
  description = "ARN of the Lambda function to update application statuses"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the Lambda Execution Role"
  type        = string
}
