#!/bin/bash

# Define the path to the src module
export PYTHONPATH=/app/src:$PYTHONPATH

# Create a virtual environment for testing
python3.10 -m venv /app/tests/unit/test-env > /dev/null

# Activate the virtual environment and install dependencies for testing
source /app/tests/unit/test-env/bin/activate > /dev/null
pip install -r /app/tests/unit/requirements.txt > /dev/null

# Add spacing
echo ""
echo ""
echo ""

# Run the unit tests with the PYTHONPATH environment variable set
python -m unittest /app/tests/unit/test_fast_lambda.py

# Deactivate the virtual environment
deactivate
