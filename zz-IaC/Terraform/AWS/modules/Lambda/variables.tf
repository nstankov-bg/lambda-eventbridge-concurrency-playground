variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "function_name" {
  type        = string
  description = "Unique name for the Lambda Function."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
  default     = ""
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function you are uploading."
  default     = ""
}

variable "iam_policy_description" {
  type        = string
  description = "Description of the IAM policy for the Lambda IAM role"
  default     = "Minimum SSM read permissions for Lambda"
}

variable "ephemeral_storage_size" {
  type        = number
  description = "The amount of storage available to the function at runtime. Defaults to 512."
  default     = 512
}

variable "lambda_environment" {
  type = object({
    variables = map(string)
  })
  default = {
    variables = {}
  }
}
variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda function. A value of 0 disables lambda from being invoked."
  type        = number
  default     = -1
}
