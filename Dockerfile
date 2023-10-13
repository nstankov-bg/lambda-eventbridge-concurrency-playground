# Use Python 3.10 as the base image
FROM python:3.10 as tests

# Set the working directory to /app
WORKDIR /app

# Copy the contents of the src and tests directories into the container at /app
COPY src/ /app/src
COPY tests/ /app/tests

# Create a virtual environment for the Lambda function and install dependencies
RUN python3.10 -m venv /app/lambda-env
RUN /app/lambda-env/bin/pip install -r /app/src/requirements.txt

# Copy the test-entrypoint.sh script into the container
COPY scripts/docker/test-entrypoint.sh /app/test-entrypoint.sh

# Make the test-entrypoint.sh script executable
RUN chmod +x /app/test-entrypoint.sh

# Define the entrypoint for the container
ENTRYPOINT ["/app/test-entrypoint.sh"]
