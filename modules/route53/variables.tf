variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "records" {
  description = "A map of record types and their details"
  type = map(map(object({
    name    = string
    records = list(string)
  })))
  # Example:
  # "MX" = {
  #   "mail" = {
  #      name    = "mail"
  #      records = ["10 mail1.example.com", "20 mail2.example.com"]
  #   }
  # }
}

variable "lb_api_dns_name" {
  description = "DNS name of the API Load Balancer"
  type        = string
}

variable "lb_api_hosted_zone_id" {
  description = "Hosted Zone ID of the API Load Balancer"
  type        = string
}

variable "cloudfront_employer_domain_name" {
  description = "Domain Name of the Cloudfront Distribution"
  type        = string
}

variable "cloudfront_employer_hosted_zone_id" {
  description = "Hosted Zone ID of the Cloudfront Distribution"
  type        = string
}

variable "acm_domain_validation_options" {
  description = "A list of ACM Domain Validation Options"
  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
}
