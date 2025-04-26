resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "${var.prefix}-billing-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600 # 6 hours (billing metrics update slowly)
  statistic           = "Maximum"
  threshold           = var.billing_threshold # in USD

  dimensions = {
    Currency = "USD"
  }

  alarm_description = "Alert when estimated AWS charges exceed $200"
  alarm_actions     = [var.billing_alert_sns_topic_arn]
}
