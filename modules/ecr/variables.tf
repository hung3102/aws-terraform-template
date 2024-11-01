variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}
