variable "account_alias" {
  type = string
}

variable "account_id" {
  type = string
}

variable "apex_domain" {
  type = string
}

variable "bootstrap_role" {
  type = string
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}
