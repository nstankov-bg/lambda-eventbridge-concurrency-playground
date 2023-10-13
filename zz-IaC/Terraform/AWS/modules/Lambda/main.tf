locals {
  enabled = module.this.enabled
  lambda_file_sha = filesha256("${path.module}/../../../../../src/handler.py")
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = "Lambda-EventBridge-Concurrency-Tests"
  namespace = "nstankov"
  stage     = "dev"
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "archive_file" "lambda_zip" {
  count        = local.enabled ? 1 : 0
  type         = "zip"
  source_dir   = "${path.module}/../../../../../src"
  output_path  = "${path.module}/lambda${local.lambda_file_sha}.zip"
}

module "lambda" {
  source              = "cloudposse/lambda-function/aws"
  version = "0.5.3"
  filename            = data.archive_file.lambda_zip[0].output_path
  function_name       = module.label.id
  handler             = "handler.lambda_handler"
  runtime             = "python3.10"
  reserved_concurrent_executions = var.reserved_concurrent_executions
  lambda_environment = var.lambda_environment
}
