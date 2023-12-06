resource "aws_api_gateway_rest_api" "default" {
  name              = var.api_name
  api_key_source    = "HEADER"
  put_rest_api_mode = var.put_rest_api_mode
  body              = file(var.open_api_json_relative_path)
  tags              = {}

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "my_rest_api" {
  rest_api_id = aws_api_gateway_rest_api.default.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.default.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id        = aws_api_gateway_deployment.my_rest_api.id
  rest_api_id          = aws_api_gateway_rest_api.default.id
  stage_name           = var.stage_name
  xray_tracing_enabled = var.xray_tracing_enabled
}
