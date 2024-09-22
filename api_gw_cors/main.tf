resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = var.api_gateway_rest_api.id
  parent_id   = var.api_gateway_rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "options" {
  rest_api_id   = var.api_gateway_rest_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options" {
  rest_api_id       = var.api_gateway_rest_api.id
  resource_id       = aws_api_gateway_resource.proxy.id
  http_method       = aws_api_gateway_method.options.http_method
  content_handling  = "CONVERT_TO_TEXT"
  type              = "MOCK"
  request_templates = { "application/json" = "{ \"statusCode\": 200 }" }
}

resource "aws_api_gateway_method_response" "options" {
  rest_api_id = var.api_gateway_rest_api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = 200

  response_parameters = { for key in keys(local.headers) : key => true }
}

resource "aws_api_gateway_integration_response" "options" {
  rest_api_id         = var.api_gateway_rest_api.id
  resource_id         = aws_api_gateway_resource.proxy.id
  http_method         = aws_api_gateway_method.options.http_method
  status_code         = 200
  response_parameters = local.headers

  depends_on = [aws_api_gateway_integration.options, aws_api_gateway_method_response.options]
}

resource "aws_api_gateway_gateway_response" "response_4xx" {
  rest_api_id   = var.api_gateway_rest_api.id
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/problem+json" = jsonencode({
      "type" : "$context.error.responseType",
      "title" : "$context.error.message",
      "detail" : "$context.error.validationErrorString"
    })
  }

  response_parameters = merge({
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'${var.allowed_origin}'"
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'${var.allowed_headers}'"
  }, local.allow_credentials_gatewayresponse)
}

resource "aws_api_gateway_gateway_response" "response_5xx" {
  rest_api_id   = var.api_gateway_rest_api.id
  response_type = "DEFAULT_5XX"

  response_templates = {
    "application/problem+json" = jsonencode({
      "type" : "$context.error.responseType",
      "title" : "$context.error.message",
      "detail" : "$context.error.validationErrorString",
    })
  }

  response_parameters = merge({
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'${var.allowed_origin}'"
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'${var.allowed_headers}'"
  }, local.allow_credentials_gatewayresponse)
}
