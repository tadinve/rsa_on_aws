import psycopg2
import os

def lambda_handler(event, context):

        rs_endpoint = os.environ['RS_ENDPOINT']
        rs_user     = os.environ['RS_USER']
        rs_pwd      = os.environ['RS_PWD']
        region      = os.environ['REGION']
        role_arn    = os.environ['ROLE_ARN']

        con=psycopg2.connect(
              dbname   = 'dev', 
              host     = rs_endpoint, 
              port     = '5439', 
              user     = rs_user, 
              password = rs_pwd)
         
        delimiter = ","

        for record in event['Records']:
            
            bucket = record['s3']['bucket']['name']
            file = record['s3']['object']['key']

            query  = "COPY stg.sales FROM 's3://" + bucket + "/" + file + "'" 
            query += "IAM_ROLE '" + role_arn + "' "
            query += "DELIMITER ',' REGION '" + region + "' TIMEFORMAT 'MM/DD/YYYY HH:MI:SS'"
            #IGNOREHEADER 1

            cur = con.cursor()
            cur.execute(query)
            con.commit()
            cur.close() 
        
        con.close()
