import sys
import time
import json, uuid, boto3
import transaction_generator
import configparser
from datetime import datetime
from apachelogs import LogParser

# from .settings import AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY

# KINESIS_REGION_NAME = 'us-west-2'

config = configparser.ConfigParser()
config.read('config.ini')
AWS_ACCESS_KEY_ID = config['kinesis_role']['AWS_ACCESS_KEY_ID']
AWS_SECRET_ACCESS_KEY = config['kinesis_role']['AWS_SECRET_ACCESS_KEY']
KINESIS_REGION_NAME = config['kinesis_config']['KINESIS_REGION_NAME']

def main(batch_stream="tf-cadabra_batch_sales", order_stream="tf-order-stream", weblogs_stream="tf-weblogs", log_file="access.log", rec_count=10000):
    push_to_orders_stream(order_stream, rec_count)
    push_to_batch_sales_firehose(batch_stream, rec_count)
    push_weblogs_to_firehose(weblogs_stream, log_file, rec_count)

    
def push_weblogs_to_firehose(weblogs_stream, log_file, rec_count):
    firehoseStreamName = weblogs_stream

    firehose_client = boto3.client(
        'firehose', 
        region_name=KINESIS_REGION_NAME, 
        aws_access_key_id=AWS_ACCESS_KEY_ID, 
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    )

    print("\n\nProcessing Log File\n")

    log_records = []
    batch_size = 500
    i = 0
    with open(file=log_file, mode='r') as log:
        for line in log:
            i+=1
            # print(line)
            try:
                log_records.append({            
                    "Data": line            
                })
            except:
                print("Issues with log file record.")

            
            if i % batch_size == 0:
                put_response = firehose_client.put_record_batch(
                    Records=log_records,
                    DeliveryStreamName=weblogs_stream
                )
                print("Web Logs Firehose Batch #{} - Failed records: {}".format(int(i / batch_size), put_response.get("FailedPutCount")))
                # print(f"Batch #{(int(i / batch_size))}")
                log_records = []
            if i == rec_count:
                break




    


def push_to_batch_sales_firehose(batch_stream, rec_count):
    firehoseStreamName = batch_stream

    firehose_client = boto3.client(
        'firehose', 
        region_name=KINESIS_REGION_NAME, 
        aws_access_key_id=AWS_ACCESS_KEY_ID, 
        aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    )

    print("\n\nProcessing Batch Sales to Firehose\n")

    batch_size = 500

    records = []
    for _ in range(rec_count//batch_size):
        records.extend(transaction_generator.generateKinesisTransactions(startDate=datetime(2018,1,1), endDate=datetime(2020,12,31), n=batch_size, OutFile=None))

    put_orders_batch_to_firehose(
        firehose_client = firehose_client,
        firehose_name=firehoseStreamName, 
        records=records, 
        batch_size=batch_size)

    
def put_orders_batch_to_firehose(firehose_client, firehose_name, records, batch_size=50):
    i = 0
    firehose_records = []

    # Create a list of kinesis records
    for rec in records:
        i += 1
        line = ", ".join(str(val) for val in rec.values())
        # print(line)

        try:
            firehose_records.append({            
                "Data": line           
            })
        except TypeError:
            try:
                print(f"InvoiceNo: {type(rec['InvoiceNo'])}")
                print(f"{rec['InvoiceNo'] = }\n")
                print(f"StockCode: {type(rec['StockCode'])}")
                print(f"{rec['StockCode'] = }\n")
                print(f"Description: {type(rec['Description'])}")
                print(f"{rec['Description'] = }\n")
                print(f"Quantity: {type(rec['Quantity'])}")
                print(f"{rec['Quantity'] = }\n")
                print(f"InvoiceDate: {type(rec['InvoiceDate'])}")
                print(f"{rec['InvoiceDate'] = }\n")
                print(f"UnitPrice: {type(rec['UnitPrice'])}")
                print(f"{rec['UnitPrice'] = }\n")
                print(f"CustomerID: {type(rec['CustomerID'])}")
                print(f"{rec['CustomerID'] = }\n")
                print(f"Country: {type(rec['Country'])}")
                print(f"{rec['Country'] = }\n")
            except:
                try:
                    print(f"{rec = }")
                except:
                    print(f"Could not print REC")


        # Every batch_size sends a put_records command

        if i % batch_size == 0:
            put_response = firehose_client.put_record_batch(
                Records=firehose_records,
                DeliveryStreamName=firehose_name
            )
            print("Firehose Orders Batch #{} - Failed records: {}".format(int(i / batch_size), put_response.get("FailedPutCount")))
            # print(f"Batch #{(int(i / batch_size))}")
            firehose_records = []

 






def push_to_orders_stream(order_stream, rec_count):
    kinesisStreamName = order_stream
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

    print("\n\nProcessing Orders to Kinesis Stream\n")

    batch_size = 500

    records = []
    for _ in range(rec_count//batch_size):
        records.extend(transaction_generator.generateKinesisTransactions(startDate=datetime(2018,1,1), endDate=datetime(2020,12,31), n=batch_size, OutFile=None))

    multi_put_to_stream(
        kinesis_client=client,
        stream_name=kinesisStreamName,
        records=records,
        batch_size=batch_size
    )


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
        except TypeError:
            try:
                print(f"InvoiceNo: {type(rec['InvoiceNo'])}")
                print(f"{rec['InvoiceNo'] = }\n")
                print(f"StockCode: {type(rec['StockCode'])}")
                print(f"{rec['StockCode'] = }\n")
                print(f"Description: {type(rec['Description'])}")
                print(f"{rec['Description'] = }\n")
                print(f"Quantity: {type(rec['Quantity'])}")
                print(f"{rec['Quantity'] = }\n")
                print(f"InvoiceDate: {type(rec['InvoiceDate'])}")
                print(f"{rec['InvoiceDate'] = }\n")
                print(f"UnitPrice: {type(rec['UnitPrice'])}")
                print(f"{rec['UnitPrice'] = }\n")
                print(f"CustomerID: {type(rec['CustomerID'])}")
                print(f"{rec['CustomerID'] = }\n")
                print(f"Country: {type(rec['Country'])}")
                print(f"{rec['Country'] = }\n")
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
            print("Kinesis Order Stream Batch #{} - Failed records: {}".format(int(i / batch_size), put_response.get("FailedRecordCount")))

            #Otherwise results in ProvisionedThroughputExceededException
            time.sleep(0.500) 

            if put_response['FailedRecordCount'] > 0:
                print(f'{put_response["Records"]}')
            kinesis_records = []
        

if __name__ == "__main__":
    # execute only if run as a script
    if len(sys.argv) > 1:
        batch_stream = sys.argv[1]
    else:
        batch_stream = "tf-cadabra_batch_sales"

    if len(sys.argv) > 2:
        order_stream = sys.argv[2]
    else:
        order_stream = "tf-order-stream"

    if len(sys.argv) > 3:
        weblogs_stream = sys.argv[3]
    else:
        weblogs_stream = "tf-weblogs"

    if len(sys.argv) > 4:
        log_file = sys.argv[4]
    else:
        log_file = 'access.log'

    if len(sys.argv) > 5:
        rec_count = int(sys.argv[5])
    else:
        rec_count = 1000

    main(batch_stream=batch_stream, order_stream=order_stream, weblogs_stream=weblogs_stream, log_file=log_file, rec_count=rec_count)
