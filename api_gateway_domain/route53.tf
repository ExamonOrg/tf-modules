resource "aws_route53_record" "default" {
  provider = aws.r53
  name     = var.domain_name
  type     = "A"
  zone_id  = var.root_domain_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.default.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.default.regional_zone_id
  }
}
