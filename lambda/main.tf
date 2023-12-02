resource "aws_lambda_function" "myLambda" {
  function_name    = var.name
  filename         = "${path.module}/empty.zip"
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  role             = aws_iam_role.lambda_role.arn
  architectures    = var.architectures
  tags             = var.tags

  ephemeral_storage {
    size = var.ephemeral_storage_size_in_gb
  }
  lifecycle {
    ignore_changes = [
      source_code_hash, filename
    ]
  }
}

output "invoke_arn" {
  value = aws_lambda_function.myLambda.invoke_arn
}

output "arn" {
  value = aws_lambda_function.myLambda.arn
}

output "function_name" {
  value = aws_lambda_function.myLambda.function_name
}