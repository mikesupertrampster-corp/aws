variable "lambda_schedule_expression" {
  type    = string
  default = "cron(0 23 * * ? *)"
}

variable "name" {
  type = string
}

variable "variables" {
  type    = map(string)
  default = { REGION = "" }
}

output "role_name" {
  value = aws_iam_role.lambda.name
}