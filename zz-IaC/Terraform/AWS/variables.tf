variable "region" {
    default = "us-east-1"
}
variable "lambda_function_name" {
  default = "lambda_function_name"
}

variable "lambda_reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this lambda function"
  type        = number
  default     = 5
}

variable "secrets_secrets" {
  description = "A map of secret names to their values"
  type        = map(string)
}
