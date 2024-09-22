locals {
  allow_credentials_method          = var.allow_credentials == true ? { "method.response.header.Access-Control-Allow-Credentials" = "'true'" } : {}
  allow_credentials_gatewayresponse = var.allow_credentials == true ? { "gatewayresponse.header.Access-Control-Allow-Credentials" = "'true'" } : {}

  headers = merge({
    "method.response.header.Access-Control-Allow-Headers" = "'${var.allowed_headers}'"
    "method.response.header.Access-Control-Allow-Methods" = "'${var.allowed_methods}'"
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.allowed_origin}'"
    "method.response.header.Access-Control-Max-Age"       = "'${var.cache_max_age}'"
  }, local.allow_credentials_method)

}
