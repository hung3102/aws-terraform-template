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

variable "api_url" {
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
