import boto3
import json

# Initialize EventBridge client
client = boto3.client("events")

# Loop to put events in batches of 10
for i in range(50):
    batch = []
    for j in range(10):
        event = {
            "EventBusName": "default",
            "Source": "my.custom.source",
            "DetailType": "ManualTrigger",
            "Detail": json.dumps({"job": "manual-trigger", "batch": i, "event": j}),
        }
        batch.append(event)

    response = client.put_events(Entries=batch)
    print(f"Batch {i+1} Response: {response}")
