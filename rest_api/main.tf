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

resource "aws_api_gateway_usage_plan" "example" {
  name         = "my-usage-plan"
  description  = "my description"
  product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.default.id
    stage  = aws_api_gateway_stage.example.stage_name
  }

  quota_settings {
    limit  = 1000
    offset = 0
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 10
    rate_limit  = 20
  }
}

resource "aws_api_gateway_api_key" "api_key_1" {
  name = "api_key_1"
}

resource "aws_api_gateway_usage_plan_key" "main" {
  key_id        = aws_api_gateway_api_key.api_key_1.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.example.id
}

