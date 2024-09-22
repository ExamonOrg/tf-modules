output "invoke_url" {
  value = aws_api_gateway_deployment.my_rest_api.invoke_url
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.default.execution_arn
}

output "api_id" {
  value = aws_api_gateway_rest_api.default.id
}

output "api_root_resource_id" {
  value = aws_api_gateway_rest_api.default.root_resource_id
}
