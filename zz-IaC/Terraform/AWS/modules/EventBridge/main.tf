module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  name    = "Lambda-EventBridge-Concurrency-Tests"
  namespace = "nstankov"
  stage   = "dev"
}

module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"
  # context = module.label.context # Todo Replace with CloudPose Context when it comes out
  create_bus = false  # Use the default bus

  rules = {
    manual_trigger = {
      description = "Manual Trigger for a Lambda"
      event_pattern = jsonencode({
        "source": [
          "my.custom.source"
        ]
      })
    },
    schedule_trigger = {  # Schedule Trigger for a Lambda
      description = "Scheduled Trigger for a Lambda"
      schedule_expression = "rate(1 minute)"
    }
  }

  targets = {
    manual_trigger = [
      {
        name  = "lambda-manual-trigger"
        arn   = var.lambda_arn
        input = jsonencode({"job": "manual-trigger"})
      }
    ],
    schedule_trigger = [
      {
        name  = "lambda-schedule-trigger"
        arn   = var.lambda_arn
        input = jsonencode({"job": "schedule-trigger"})
      }
    ]
  }
}

output "eventbridge_bus_arn" {
  value = module.eventbridge.eventbridge_bus_arn
}

output "eventbridge_bus_name" {
  value = module.eventbridge.eventbridge_bus_name
}
