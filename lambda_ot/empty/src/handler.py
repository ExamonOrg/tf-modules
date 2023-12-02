import json



def lambda_handler(event: dict, context):
    try:
        return {
            "statusCode": 200,
            "headers": {"content-type": "application/json"},
            "body": json.dumps({})
        }
    except Exception as e:
        return {"code": 400, "message": "Error"}
