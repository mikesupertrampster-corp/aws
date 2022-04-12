data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "logs" {
  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]

    resources = [
      "${aws_cloudwatch_log_group.log.arn}*:*"
    ]
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/apps/${var.name}/${var.name}"
  output_path = "${path.module}/apps/${var.name}/${var.name}.zip"
}