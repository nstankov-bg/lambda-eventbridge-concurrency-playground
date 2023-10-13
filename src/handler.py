# Imports
import json
import logging
import os
import time
from typing import Any, Dict, Union

# Constants and Configurations
HTTP_OK = 200
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")

# Initialize Logging
logging.basicConfig(level=LOG_LEVEL)
logger = logging.getLogger(__name__)


def fetch_result() -> str:
    """Simulated function that fetches the result."""
    return "Fast execution"


def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Union[int, str]]:
    """AWS Lambda function handler."""
    start_time = time.time()
    logger.info(f"Received event: {json.dumps(event)}")

    # Fetch the result
    result = fetch_result()

    end_time = time.time()
    execution_time = end_time - start_time
    logger.info(f"Execution time: {execution_time} seconds")

    return {
        "statusCode": HTTP_OK,
        "body": json.dumps({"result": result, "execution_time": execution_time}),
    }
