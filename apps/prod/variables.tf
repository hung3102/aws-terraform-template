variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "route53_records" {
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
