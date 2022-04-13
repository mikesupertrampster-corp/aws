variable "cluster_arn" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "name" {
  type    = string
  default = "jaeger"
}

variable "subnet_ids" {
  type = list(string)
}

variable "jaeger_image" {
  type    = string
  default = "jaegertracing/all-in-one:1.33"
}

variable "vpc_id" {
  type = string
}
