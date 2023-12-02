resource "aws_api_gateway_domain_name" "default" {
  domain_name              = var.domain_name
  regional_certificate_arn = var.regional_certificate_arn
  security_policy          = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "default" {
  domain_name = aws_api_gateway_domain_name.default.domain_name
  stage_name = var.stage_name
  api_id = var.api_id
}

resource "aws_route53_record" "default" {
  name     = var.domain_name
  type     = "A"
  zone_id  = var.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.default.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.default.regional_zone_id
  }
}
