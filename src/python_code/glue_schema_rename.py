#Rename the Glue Table Columns
import boto3

def rename_glue_schema(database_name='tf-cadabra_glue',table_name='salestransactions'):

    #parameters to receive from user
    database_name = database_name
    table_name = table_name
    new_col_names = ['invoiceno','stockcode','description','quantity','invoicedate','unitprice','customerid','country']
    new_partition_keys = ['year','month','day','hour']

    #Schema Change TableInput should have these fields
    #Donot Change
    field_names = [
          "Name",
          "Description",
          "Owner",
          "LastAccessTime",
          "LastAnalyzedTime",
          "Retention",
          "StorageDescriptor",
          "PartitionKeys",
          "ViewOriginalText",
          "ViewExpandedText",
          "TableType",
          "Parameters"
        ]

    client = boto3.client('glue')
    response = client.get_table(DatabaseName=database_name,Name=table_name)
    table_definiton = response['Table']

    #sanity check before replacing col field_names
    tot_col_names_provided = len(new_col_names)
    tot_partition_col_names_provided = len(new_partition_keys)
    tot_col_names = len(table_definiton['StorageDescriptor']['Columns'])
    tot_partition_col_names = len(table_definiton['PartitionKeys'])

    if tot_col_names_provided != tot_col_names:
        print("Total Columns Provided doesnt match number of glue table columns")
    elif tot_partition_col_names_provided != tot_partition_col_names:
        print("Partition Columns Provided doesnt match Partition Columns of glue table")
    else:
        #create a new dictionary object and pull all the required values from the existing
        #table easiest way to create a tableinput
        table_input = dict()
        for key in field_names:
          if key in table_definiton:
            table_input[key] = table_definiton[key]

        idx = 0 #setting index = 0
        #iterate through storage descriptor columns and change the column names
        for col in table_input['StorageDescriptor']['Columns']:
          col['Name'] = new_col_names[idx]
          idx+=1
          print(col)
        idx = 0 #resetting index = 0
        #iterate through partition key columns and change the column names
        for col in table_input['PartitionKeys']:
          col['Name'] = new_partition_keys[idx]
          idx+=1
          print(col)
        #update the table using boto3 client
        response = client.update_table(DatabaseName=database_name,TableInput=table_input)
        print("Rename Complete")

