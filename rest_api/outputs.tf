output "invoke_url" {
  value = aws_api_gateway_deployment.my_rest_api.invoke_url
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.default.execution_arn
}