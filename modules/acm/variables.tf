variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "route53_acm_records" {
  description = "A map of record types and their details"
  type        = map(any)
}
