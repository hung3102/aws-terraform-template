provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_sns_topic" "billing_alerts" {
  provider = aws.virginia
  name     = "${var.prefix}-billing-alerts-topic"
}

resource "aws_sns_topic_subscription" "billing_alerts_email_subscription" {
  provider  = aws.virginia
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.billing_alert_email
}
