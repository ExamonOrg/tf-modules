resource "aws_acm_certificate" "cert" {
  provider                  = aws.eu_west_1
  domain_name               = "*.${var.root_domain}"
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.eu_west_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.record_cert_validation : record.fqdn]
  timeouts {
    create = "45m"
  }
}

resource "aws_route53_record" "record_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}