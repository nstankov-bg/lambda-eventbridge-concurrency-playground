import boto3
import json

# Initialize EventBridge client
client = boto3.client("events")

# Custom EventBus Name
custom_event_bus_name = "default"

# Loop to put events in batches of 10
for i in range(50):
    batch = []
    for j in range(10):
        event = {
            "EventBusName": custom_event_bus_name,
            "Source": "my.custom.source",
            "DetailType": "ManualTrigger",
            "Detail": json.dumps({"job": "manual-trigger", "batch": i, "event": j}),
        }
        batch.append(event)

    response = client.put_events(Entries=batch)
    print(f"Batch {i+1} Response: {response}")
