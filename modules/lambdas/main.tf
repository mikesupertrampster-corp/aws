resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = title(var.name)
  schedule_expression = var.lambda_schedule_expression
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/lambda/${title(var.name)}"
  retention_in_days = 7
}

resource "aws_iam_role" "lambda" {
  name               = "${title(var.name)}LambdaRole"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_iam_role_policy" "logs" {
  role   = aws_iam_role.lambda.id
  name   = "LogStreaming"
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda.output_path
  role             = aws_iam_role.lambda.arn
  function_name    = title(var.name)
  handler          = var.name
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)
  runtime          = "go1.x"

  environment {
    variables = var.variables
  }
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.event_rule.name
  arn  = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule.arn
}