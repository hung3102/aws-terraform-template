variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "nat_eip_id" {
  description = "NAT EIP ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "internet_gateway" {
  description = "Internet Gateway"
}
