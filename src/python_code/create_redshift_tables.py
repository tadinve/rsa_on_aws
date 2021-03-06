import boto3
import time

def create_schema_tables(database='dev',user='awsuser'):
   client = boto3.client('redshift-data')

   create_schema      = "CREATE SCHEMA stg AUTHORIZATION awsuser"

   create_sales_table = "CREATE TABLE stg.sales ("
   create_sales_table +=      "invoiceno varchar,"
   create_sales_table +=      "stockcode varchar,"
   create_sales_table +=      "description varchar(300),"
   create_sales_table +=      "quantity integer,"
   create_sales_table +=      "invoicedate datetime,"
   create_sales_table +=      "unitprice decimal(10,2),"
   create_sales_table +=      "customerid varchar,"
   create_sales_table +=      "country varchar)"
   
   response = client.execute_statement(
    	ClusterIdentifier='tf-redshift-cluster',
    	Database='dev',
    	DbUser='awsuser',
    	Sql=create_schema,
    	StatementName='create_schema'
   )
   print(response)
   time.sleep(5)

   response = client.execute_statement(
        ClusterIdentifier='tf-redshift-cluster',
        Database='dev',
        DbUser='awsuser',
        Sql=create_sales_table,
        StatementName='create_sales_table'
   )
   print(response)
