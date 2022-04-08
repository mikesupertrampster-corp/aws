variable "region" {
  type = string
}

variable "organisation_units" {
  type = set(string)
}

variable "tags" {
  type = map(string)
}