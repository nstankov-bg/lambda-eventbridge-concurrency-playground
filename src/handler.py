import json
import logging
import os
import time
from typing import Any, Dict, Optional, Union

import requests

# Constants
HTTP_OK = 200
AWS_SESSION_TOKEN = os.getenv("AWS_SESSION_TOKEN", None)
SECRET_ENDPOINT = os.getenv(
    "SECRET_ENDPOINT", "http://localhost:2773/secretsmanager/get?secretId={}"
)
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")

# Initialize logging
logging.basicConfig(level=LOG_LEVEL)
logger = logging.getLogger(__name__)


def fetch_secret_from_extension(secret_name: str) -> Optional[str]:
    """Fetch a secret from AWS Secrets Manager Lambda extension."""
    headers = {"X-Aws-Parameters-Secrets-Token": AWS_SESSION_TOKEN}
    secret_endpoint = SECRET_ENDPOINT.format(secret_name)
    try:
        response = requests.get(secret_endpoint, headers=headers)
        response.raise_for_status()
        return json.loads(response.text)["SecretString"]
    except requests.RequestException as e:
        logger.error(f"Error retrieving secret {secret_name}: {e}")
        return None


def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Union[int, str]]:
    """AWS Lambda function handler."""
    start_time = time.time()
    logger.info(f"Received event: {json.dumps(event)}")

    result = "Fast execution"

    end_time = time.time()
    execution_time = end_time - start_time
    logger.info(f"Execution time: {execution_time} seconds")

    return {
        "statusCode": HTTP_OK,
        "body": json.dumps({"result": result, "execution_time": execution_time}),
    }
