terraform {
  required_providers {
    shell = {
      source = "scottwinkler/shell"
    }
  }
}

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

resource "shell_script" "go_build" {
  count             = 0
  working_directory = "${path.module}/apps/${var.name}"

  environment = {
    CGO_ENABLED = 0
    GOOS        = "linux"
    GOARCH      = "amd64"
  }

  lifecycle_commands {
    create = "go build"
    delete = "rm -f ${var.name}"
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/apps/${var.name}/${var.name}"
  output_path = "${path.module}/apps/${var.name}/${var.name}.zip"
}