variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "igw_id" {
  description = "IGW ID"
  type        = string
}

# variable "nat_gateway_id" {
#   description = "NAT Gateway ID"
#   type        = string
# }

variable "nat_instance_network_interface_id" {
  description = "NAT Instance Network Interface ID"
  type        = string
}
