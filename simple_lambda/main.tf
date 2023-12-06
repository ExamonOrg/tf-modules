data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "lambda_role" {
  name               = "role_lambda_handler_${var.function_name}"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  for_each   = toset(var.policy_attachments)
  role       = aws_iam_role.lambda_role.name
  policy_arn = each.key
}

data "archive_file" "h1_lambda_function" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
}

resource "aws_lambda_function" "handler1" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  source_code_hash = data.archive_file.h1_lambda_function.output_base64sha256
  filename         = data.archive_file.h1_lambda_function.output_path
  handler          = var.handler
  runtime          = var.runtime
  environment {
    variables = merge(var.env, {})
  }
}