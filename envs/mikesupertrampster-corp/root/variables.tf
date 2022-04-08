variable "accounts" {
  type = map(object({
    organisation_unit = string
  }))
}

variable "bootstrap_role" {
  type = string
}

variable "organisation_email_pattern" {
  type = string
}

variable "organisation_units" {
  type = set(string)
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}