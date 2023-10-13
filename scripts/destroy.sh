#!/bin/bash

# Navigate to the src directory
cd src

# Deactivate any active virtual environment (this step is optional, but recommended)
# This assumes the deactivate function is available; if not, this line will simply return an error which can be ignored
deactivate 2>/dev/null

# Delete the lambda-env virtual environment
rm -rf lambda-env

# Delete the __pycache__ directory
rm -rf __pycache__

cd ..
# Navigate to the tests/unit directory
cd tests/unit

# Deactivate any active virtual environment (again, this step is optional but recommended)
# This assumes the deactivate function is available; if not, this line will simply return an error which can be ignored
deactivate 2>/dev/null

# Delete the test-env virtual environment
rm -rf test-env

# Delete the __pycache__ directory
rm -rf __pycache__

# Navigate back to the root directory
cd ../../..
