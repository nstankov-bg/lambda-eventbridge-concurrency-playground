variable "lambda_arn" {
  description = "The ARN of the Lambda function"
  type        = string
}

variable "region" {
  description = "The region where the Lambda function is deployed"
  type        = string
  default   = "us-east-1"
}
