import json, uuid, boto3
import transaction_generator
import configparser
from datetime import datetime

# from .settings import AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY

# KINESIS_REGION_NAME = 'us-west-2'

config = configparser.ConfigParser()
config.read('config.ini')
AWS_ACCESS_KEY_ID = config['kinesis_role']['AWS_ACCESS_KEY_ID']
AWS_SECRET_ACCESS_KEY = config['kinesis_role']['AWS_SECRET_ACCESS_KEY']
KINESIS_REGION_NAME = config['kinesis_config']['KINESIS_REGION_NAME']

def main():

    kinesisStreamName = 'CadabraOrders'
    shard_level_metrics = ['ALL']

    # 
    # client = boto3.client('kinesis', region_name='us-west-2')

    client = boto3.client(
        'kinesis', 
        region_name=KINESIS_REGION_NAME, 
        aws_access_key_id=AWS_ACCESS_KEY_ID,
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    )

    response = client.enable_enhanced_monitoring(
        StreamName = kinesisStreamName,
        ShardLevelMetrics=shard_level_metrics
    )

    records = []
    for _ in range(100):
        records.extend(transaction_generator.generateKinesisTransactions(startDate=datetime(2018,1,1), endDate=datetime(2020,12,31), n=100, OutFile=None))

    multi_put_to_stream(
        kinesis_client=client,
        stream_name=kinesisStreamName,
        records=records,
        batch_size=100
    )
    

    # print(records)


def multi_put_to_stream(kinesis_client, stream_name, records, batch_size=100):
    i = 0
    kinesis_records = []

    # Create a list of kinesis records
    for rec in records:
        i += 1
        try:
            kinesis_records.append({            
                "Data": json.dumps(rec),            
                "PartitionKey": str(uuid.uuid4())
            })
        except:
            try:
                print(f"{rec = }")
            except:
                print(f"Could not print REC")


        # Every batch_size sends a put_records command

        if i % batch_size == 0:
            put_response = kinesis_client.put_records(
                Records=kinesis_records,
                StreamName=stream_name
            )
            print("Batch #{} - Failed records: {}".format(int(i / batch_size), put_response.get("FailedRecordCount")))

            #clear out kinesis_records batch
            kinesis_records = [] 
        

if __name__ == "__main__":
    # execute only if run as a script
    main()