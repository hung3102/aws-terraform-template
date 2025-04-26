variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "billing_alert_sns_topic_arn" {
  description = "SNS Topic ARN for billing alerts"
  type        = string
}

variable "billing_threshold" {
  description = "Billing threshold for the alarm in USD"
  type        = number
}
