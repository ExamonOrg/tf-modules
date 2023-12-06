variable "source_dir" {
  description = "The directory containing the lambda function code"
}

variable "output_path" {
  description = "The path to the zip file to be created"
  default     = "my_lambda_function.zip"
}

variable "policy_attachments" {
  description = "Policies to attach to the lambda function"
  default     = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

variable "function_name" {
  description = "Function name"
}

variable "handler" {
  description = "Handler function"
}

variable "runtime" {
  description = "Runtime"
}

variable "env" {
  description = "env vars"
  default     = {}
}