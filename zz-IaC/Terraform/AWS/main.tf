# Pass the secret ARNs to the Lambda using your Lambda module
module "lambda" {
  source = "./modules/Lambda" # Update this path
  region = var.region
  function_name = var.lambda_function_name
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions
}

# Pass the Lambda ARN to the EventBridge using your EventBridge module
module "eventbridge" {
  region = var.region
  source = "./modules/EventBridge" # Update this path
  lambda_arn = module.lambda.arn # Assuming 'arn' is an output from your Lambda module
}


# Permission for EventBridge to invoke Lambda
resource "aws_lambda_permission" "eventbus" {

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = module.eventbridge.eventbridge_bus_arn
}
