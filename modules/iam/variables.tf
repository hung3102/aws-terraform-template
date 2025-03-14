variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "employer_static_bucket_name" {
  description = "Employer Static Bucket Name"
  type        = string
}
