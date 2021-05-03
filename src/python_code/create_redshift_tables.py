import boto3

def create_schema_tables(database='dev',user='awsuser'):
   client = boto3.client('redshift-data')

   create_schema      = "CREATE SCHEMA stg AUTHORIZATION awsuser"

   create_sales_table = "CREATE TABLE stg.sales ("
   create_sales_table +=      "invoiceno varchar,"
   create_sales_table +=      "stockcode varchar,"
   create_sales_table +=      "description varchar(300),"
   create_sales_table +=      "quantity integer,"
   create_sales_table +=      "invoicedate datetime,"
   create_sales_table +=      "unitprice decimal,"
   create_sales_table +=      "customerid varchar,"
   create_sales_table +=      "country varchar)"
   
   response = client.execute_statement(
    	ClusterIdentifier='tf-redshift-cluster',
    	Database='dev',
    	DbUser='awsuser',
    	Sql=create_schema,
    	StatementName='create_schema'
   )
   print("create_schema Status Code: " + response[ResponseMetadata][HTTPStatusCode])

   response = client.execute_statement(
        ClusterIdentifier='tf-redshift-cluster',
        Database='dev',
        DbUser='awsuser',
        Sql=create_sales_table,
        StatementName='create_sales_table'
   )
   print("create_sales_table Status Code: " + response[ResponseMetadata][HTTPStatusCode] )
