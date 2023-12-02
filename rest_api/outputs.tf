output "invoke_url" {
  value = aws_api_gateway_deployment.my_rest_api.invoke_url
}

output "api_key_value" {
  value     = aws_api_gateway_api_key.api_key_1.value
  sensitive = true
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.default.execution_arn
}