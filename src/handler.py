import json
import logging
import os
import time
from typing import Any, Dict, Union

HTTP_OK = 200
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")

WARM_START_INDICATOR = None

logger = logging.getLogger(__name__)
handler = logging.StreamHandler()
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(LOG_LEVEL)


def fetch_result(is_warm_start: bool) -> str:
    if is_warm_start:
        return "Fast execution due to warm start"
    else:
        time.sleep(2)
        return "Slow execution due to cold start"


def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Union[int, str]]:
    global WARM_START_INDICATOR

    start_time = time.perf_counter()

    if logger.isEnabledFor(logging.INFO):
        logger.info(f"Received event: {json.dumps(event)}")

    is_warm_start = WARM_START_INDICATOR is not None
    WARM_START_INDICATOR = True

    result = fetch_result(is_warm_start)

    end_time = time.perf_counter()
    execution_time = end_time - start_time

    response = {
        "statusCode": HTTP_OK,
        "body": json.dumps(
            {
                "result": result,
                "execution_time": execution_time,
                "is_warm_start": is_warm_start,
                "memory_limit": context.memory_limit_in_mb,
                "remaining_time": context.get_remaining_time_in_millis(),
            }
        ),
    }

    if logger.isEnabledFor(logging.INFO):
        logger.info(f"Execution Summary: {json.dumps(response)}")

    return response
