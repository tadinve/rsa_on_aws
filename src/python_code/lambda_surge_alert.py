import boto3
import base64
import os

client = boto3.client('sns')
# Include your SNS topic ARN here.
topic_arn = os.environ['TOPIC_ARN'] 

def lambda_handler(event, context):
    try:
        client.publish(TopicArn=topic_arn, Message='Investigate sudden surge in orders', Subject='Cadabra Order Rate Alarm')
        print('Successfully delivered alarm message')
    except Exception:
        print('Delivery failure')
