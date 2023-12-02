variable "api_name" {
  default = "rest-api"
}

variable "put_rest_api_mode" {
  default = "merge"
}

variable "stage_name" {
  default = "v1"
}

variable "open_api_json_relative_path" {
}

variable "xray_tracing_enabled" {
  default = true
}