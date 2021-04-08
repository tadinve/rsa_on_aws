resource "aws_kinesis_analytics_application" "transaction_rate_monitor" {
  name = "tf-transaction_rate_monitor"
  code = file("create_sql_streams.sql")
  
  inputs {
    name_prefix = "SOURCE_SQL_STREAM"
    kinesis_stream {
      resource_arn = aws_kinesis_stream.kinesis_cadabra_orders.arn
      role_arn     = aws_iam_role.iam_kinesis_app.arn
    }
    parallelism {
      count = 1
    }
    schema {
      record_columns {
          mapping  = "$.InvoiceNo"  
          name     = "InvoiceNo"
          sql_type = "INTEGER"
      }
      record_columns {
          mapping  = "$.StockCode"  
          name     = "StockCode"
          sql_type = "VARCHAR(10)"
      }
      record_columns {
          mapping  = "$.Description"
          name     = "Description"
          sql_type = "VARCHAR(100)"
      }
      record_columns {
          mapping  = "$.Quantity"
          name     = "Quantity"
          sql_type = "INTEGER"
      }
      record_columns {
          mapping  = "$.InvoiceDate"
          name     = "InvoiceDate"
          sql_type = "VARCHAR(25)"
      }
      record_columns {
          mapping  = "$.UnitPrice"
          name     = "UnitPrice"
          sql_type = "REAL"
      }
      record_columns {
          mapping  = "$.Customer"
          name     = "Customer"
          sql_type = "INTEGER"
      }
      record_columns {
          mapping  = "$.Country"
          name     = "Country"
          sql_type = "VARCHAR(256)"
      }
      record_encoding = "UTF-8"
      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
    }
    starting_position_configuration {
      starting_position = "TRIM_HORIZON"
    }
  }

  outputs {
    name = "TRIGGER_COUNT_STREAM"
    schema {
      record_format_type = "JSON"
    }
    kinesis_stream {
      resource_arn = aws_kinesis_stream.kinesis_order_ratealarms.arn
      role_arn     = aws_iam_role.iam_kinesis_app.arn
    }
  }
  start_application = true

  tags = local.common_tags
}
