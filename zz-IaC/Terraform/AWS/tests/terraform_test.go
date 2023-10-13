package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform configuration
func TestTerraform(t *testing.T) {
	t.Parallel()

	awsRegion := "us-east-1" // Update this to your AWS region

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "../", // Update this path
		VarFiles:     []string{"terraform.tfvars"},
		Vars: map[string]interface{}{
			"region": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	// Deploy the Terraform configuration
	terraform.InitAndApply(t, terraformOptions)

	// Validate the Lambda function
	validateLambda(t, terraformOptions, awsRegion)
}

func validateLambda(t *testing.T, terraformOptions *terraform.Options, awsRegion string) {
	// Look up the Lambda function by name
	functionName := terraform.Output(t, terraformOptions, "lambda_function_name")
	assert.NotNil(t, functionName)

	// Check the Lambda function's settings
	reservedConcurrentExecutions := terraform.Output(t, terraformOptions, "lambda_reserved_concurrent_executions")
	assert.NotNil(t, reservedConcurrentExecutions)
}
