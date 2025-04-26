resource "aws_sns_topic" "billing_alerts" {
  name = "${var.prefix}-billing-alerts-topic"
}

resource "aws_sns_topic_subscription" "billing_alerts_email_subscription" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.billing_alert_email
}
