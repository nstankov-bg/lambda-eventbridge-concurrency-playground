#!/bin/bash

# Navigate to the src directory
cd src

# Create a virtual environment for the Lambda function
python3.10 -m venv lambda-env

# Activate the virtual environment and install dependencies for the Lambda function
source lambda-env/bin/activate  # On Windows, use: lambda-env\Scripts\activate
pip install -r requirements.txt

# Deactivate the current virtual environment
deactivate
cd ..
# Navigate to the tests/unit directory
cd tests/unit

# Create a virtual environment for testing
python3.10 -m venv test-env

# Activate the virtual environment and install dependencies for testing
source test-env/bin/activate  # On Windows, use: test-env\Scripts\activate
pip install -r requirements.txt

# Optionally, run the unit tests
# python -m unittest test_fast_lambda.py

# Deactivate the virtual environment
deactivate

# Navigate back to the root directory
cd ../../..
