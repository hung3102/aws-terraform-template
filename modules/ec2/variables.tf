variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "bastion_host_security_group_ids" {
  description = "Bastion Host Security Group IDs"
  type        = list(string)
}

variable "db_host" {
  description = "DB Host"
  type        = string
}

variable "db_port" {
  description = "DB Port"
  type        = number
}

variable "db_user" {
  description = "DB User"
  type        = string
}

variable "db_password" {
  description = "DB Password"
  type        = string
}

variable "db_name" {
  description = "DB Name"
  type        = string
}

variable "bastion_host_eip_id" {
  description = "Bastion Host EIP ID"
  type        = string
}

variable "bastion_host_instance_type" {
  description = "Bastion Host Instance Type"
  type        = string
}

variable "bastion_host_role_name" {
  description = "Bastion Host Role Name"
  type        = string
}
