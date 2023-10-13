package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraform(t *testing.T) {
	awsRegions := []string{"us-east-1", "us-east-2"}

	for _, region := range awsRegions {
		t.Run(region, func(t *testing.T) {
			t.Parallel()

			terraformOptions := &terraform.Options{
				TerraformDir: "../",
				VarFiles:     []string{"terraform.tfvars"},
				Vars: map[string]interface{}{
					"region": region,
				},
			}

			defer terraform.Destroy(t, terraformOptions)
			terraform.InitAndApply(t, terraformOptions)
			validateLambda(t, terraformOptions)
			validateEventBridge(t, terraformOptions)
		})
	}
}

func validateLambda(t *testing.T, terraformOptions *terraform.Options) {
	functionName := terraform.Output(t, terraformOptions, "lambda_function_name")
	assert.NotNil(t, functionName)
	assert.NotEmpty(t, functionName)

	reservedConcurrentExecutions := terraform.Output(t, terraformOptions, "lambda_reserved_concurrent_executions")
	assert.NotNil(t, reservedConcurrentExecutions)
	assert.NotEmpty(t, reservedConcurrentExecutions)
}

func validateEventBridge(t *testing.T, terraformOptions *terraform.Options) {
	eventBridgeName := terraform.Output(t, terraformOptions, "event_bridge_name")
	assert.NotNil(t, eventBridgeName)
	assert.NotEmpty(t, eventBridgeName)

	eventBridgeRuleName := terraform.Output(t, terraformOptions, "event_bridge_rule_name")
	assert.NotNil(t, eventBridgeRuleName)
	assert.NotEmpty(t, eventBridgeRuleName)
}
