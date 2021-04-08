variable "name_initials" {
  type = string
}

variable "user_phone" {
  type = string
}

variable "user_ipaddress" {
  type = string
}

variable "redshift_user" {
  type = string
}

variable "redshift_password" {
  type      = string
  sensitive = true
}
