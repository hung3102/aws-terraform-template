variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated Storage"
  type        = number
}

variable "db_username" {
  description = "DB Username"
  type        = string
}

variable "db_password" {
  description = "DB Password"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip Final Snapshot"
  type        = bool
}

variable "rds_sg_id" {
  description = "RDS Security Group ID"
  type        = string
}

variable "instance_class" {
  description = "Instance Class"
  type        = string
}

variable "private_subnet_group_name" {
  description = "Private Subnet Group Name"
  type        = string
}
