#!/bin/bash

# Define the path to the src module
export PYTHONPATH=$(pwd)/src:$PYTHONPATH


# Navigate to the tests/unit directory
cd tests/unit

# Create a virtual environment for testing
python3.10 -m venv test-env > /dev/null

# Activate the virtual environment and install dependencies for testing
source test-env/bin/activate > /dev/null
pip install -r requirements.txt > /dev/null

# Add a bunch of space
echo ""
echo ""
echo ""

# Run the unit tests with the PYTHONPATH environment variable set
python -m unittest test_fast_lambda.py

# Deactivate the virtual environment
deactivate

# Navigate back to the root directory
cd ../../
