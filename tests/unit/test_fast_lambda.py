import unittest
from unittest.mock import Mock
import json
from src import handler


class ContextManagerMock(Mock):
    def __enter__(self):
        return self

    def __exit__(self, *args):
        pass


class TestHandler(unittest.TestCase):
    def test_lambda_handler(self):
        event = {"test": "event"}
        context = Mock()
        response = handler.lambda_handler(event, context)
        self.assertEqual(response["statusCode"], 200)
        self.assertIn("execution_time", json.loads(response["body"]))

    # Add more tests#


if __name__ == "__main__":
    unittest.main()
