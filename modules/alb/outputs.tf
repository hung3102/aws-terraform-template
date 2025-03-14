output "target_group_primary_arn" {
  value = aws_lb_target_group.primary.arn
}

output "target_group_secondary_arn" {
  value = aws_lb_target_group.secondary.arn
}

output "target_group_primary_name" {
  value = aws_lb_target_group.primary.name
}

output "target_group_secondary_name" {
  value = aws_lb_target_group.secondary.name
}

output "api_lb" {
  value = aws_lb.api
}

output "lb_listener_arn" {
  value = aws_lb_listener.api_https.arn
}
