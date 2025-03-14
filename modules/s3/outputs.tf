// bucket domain name
output "employer_static_bucket_domain_name" {
  value = aws_s3_bucket.employer_static_bucket.bucket_regional_domain_name
}

output "resume_bucket_name" {
  value = aws_s3_bucket.resume_bucket.bucket
}

output "public_bucket_name" {
  value = aws_s3_bucket.asset_bucket.bucket
}

output "employer_static_bucket_name" {
  value = aws_s3_bucket.employer_static_bucket.bucket
}
