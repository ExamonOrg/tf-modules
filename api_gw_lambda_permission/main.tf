resource "aws_lambda_permission" "permission_1" {
  statement_id  = "AllowExecutionFromRestAPI_${var.function_name}"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*"
}
