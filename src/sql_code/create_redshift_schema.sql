CREATE EXTERNAL SCHEMA ORDERLOG_SCHEMA FROM DATA CATALOG
DATABASE 'orderlogs_db'
iam_role 'arn:aws:iam::<ACCOUNT_ID>:role/tf-redshift_role'
region '<YOUR_REGION>'

#Sample SQL Query
SELECT description, count(*) from orderlog_schema.salestransactions
where country='France' and year='2021' and month='04' group by description
