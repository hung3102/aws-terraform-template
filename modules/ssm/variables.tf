variable "prefix" {
  description = "Name Prefix"
  type        = string
}

variable "app_env" {
  type = string
}

variable "jwt_access_secret" {
  type = string
}

variable "jwt_refresh_secret" {
  type = string
}

variable "cors" {
  type = string
}

variable "app_port" {
  type = number
}

variable "api_url" {
  type = string
}

variable "resume_bucket_name" {
  type = string
}

variable "public_bucket_name" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "no_reply_email" {
  type = string
}

variable "employer_url" {
  type = string
}

variable "user_url" {
  type = string
}

variable "sentry_dsn" {
  type = string
}

variable "admin_email" {
  type = string
}

variable "scheduler_secret_token" {
  type = string
}
