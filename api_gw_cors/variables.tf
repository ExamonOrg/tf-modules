variable "api_gateway_rest_api" {
  description = "API gateway rest api resource"
}
variable "allowed_headers" {
  description = "Allowed headers"
  default     = "Content-Type,Authorization,Accept,X-Amz-Date,X-Amz-Security-Token,X-Api-Key,X-Requested-With,traceparent"
  type        = string
}
variable "allowed_methods" {
  description = "Allowed methods"
  default     = "ANY"
  type        = string
}
variable "allowed_origin" {
  description = "Allowed origin"
  default     = "*"
  type        = string
}
variable "allow_credentials" {
  description = "Allow credentials"
  default     = true
  type        = bool
}
variable "cache_max_age" {
  description = "Response cache time in seconds"
  default     = 7200
  type        = number
}
