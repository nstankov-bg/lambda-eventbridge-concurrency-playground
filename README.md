# AWS Lambda and EventBus Testing Repository

## Overview

This repository is specifically designed for testing various AWS Lambda features in conjunction with the AWS EventBus service. The tests aim to evaluate:

- Lambda concurrency
- Lambda execution environment
- Lambda context
- Cold and warm starts

The repository utilizes Python, Docker, and Terraform to set up both the local testing environment and AWS resources.

## Components

### Dockerfile

Builds a Docker container, mirroring the AWS Lambda execution environment for accurate local testing.

### Makefile

A Makefile is included to automate various tasks. The available targets include:

- `make init`: Sets up the local virtual environment.
- `make test`: Runs unit tests.
- `make destroy`: Tears down the local virtual environment.
- `make terraform-plan` and `make terraform-deploy`: Manage AWS Terraform infrastructure.
- `make docker-build` and `make docker-run`: Build and run Docker containers.

Refer to the Makefile for the complete list of targets.

### Scripts

- `init.sh`: Initializes a local virtual environment (`virtenv`).
- `destroy.sh`: Deletes the local virtual environment.
- `unit.sh`: Executes unit tests, focusing on Lambda logging and responsiveness.
- `docker/test-entrypoint.sh`: Acts as the Docker entry point to simulate the Lambda execution environment.

### SRC Folder

- `handler.py`: Contains Lambda function code to work with EventBus and carry out tests.
- `requirements.txt`: Lists Python dependencies for the Lambda function.

### Tests

- `integration/main.py`: Conducts integration tests between EventBus and Lambda.
- `unit/test_fast_lambda.py`: Unit tests that emphasize Lambda logging and response times.

### zz-IaC (Infrastructure as Code)

- `Terraform/AWS`: Holds Terraform scripts, outlining the required AWS resources like Lambda functions and EventBus.

## How to Use

1. **Local Setup**: Run `make init` or `./scripts/init.sh` to establish the local environment.
2. **Local Testing**: Use `make test` to run unit tests locally. Make sure to build the Docker image beforehand with `make docker-build`.
3. **AWS Deployment**: Run `make terraform-deploy` to roll out the Lambda function and other AWS infrastructure.
4. **Teardown**: Utilize `./scripts/destroy.sh` or `make destroy` to delete the local environment and `make terraform-destroy` to delete AWS resources.

## Additional Notes

Why I use zz, check `zz-IaC/README.md`.

## Cost Analysis

To analyze the cost implications of the AWS setup, run `make terraform-cost`. This will generate a cost breakdown and open an HTML file with the latest cost analysis.
