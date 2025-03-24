variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "domain" {
  description = "Domain"
  type        = string
}

variable "amazonses_dkim_record" {
  description = "DKIM Record"
  type        = any
}
