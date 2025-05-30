output "employer_distribution_arn" {
  value = aws_cloudfront_distribution.employer_distribution.arn
}

output "user_distribution_arn" {
  value = aws_cloudfront_distribution.user_distribution.arn
}

output "employer_domain_name" {
  value = aws_cloudfront_distribution.employer_distribution.domain_name
}

output "user_domain_name" {
  value = aws_cloudfront_distribution.user_distribution.domain_name
}

output "employer_hosted_zone_id" {
  value = aws_cloudfront_distribution.employer_distribution.hosted_zone_id
}

output "user_hosted_zone_id" {
  value = aws_cloudfront_distribution.user_distribution.hosted_zone_id
}
