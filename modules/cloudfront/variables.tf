variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "employer_static_bucket_domain_name" {
  description = "Employer S3 Bucket Domain Name"
  type        = string
}

variable "user_static_bucket_domain_name" {
  description = "User S3 Bucket Domain Name"
  type        = string
}

variable "public_bucket_domain_name" {
  description = "Asset S3 Bucket Domain Name"
  type        = string
}

variable "acm_cert_arn" {
  description = "ACM Certificate ARN"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}
