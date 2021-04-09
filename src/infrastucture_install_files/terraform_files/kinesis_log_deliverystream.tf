resource "aws_kinesis_firehose_delivery_stream" "tf-weblogs" {
  name        = "tf-weblogs"
  destination = "elasticsearch" 
  tags        = local.common_tags

  s3_configuration {
    role_arn        = aws_iam_role.firehose-log-stream-role.arn
    bucket_arn      = aws_s3_bucket.failed-logs-s3bucket.arn
    buffer_size     = 5
    buffer_interval = 60
  }

  elasticsearch_configuration {
    domain_arn             = aws_elasticsearch_domain.es-cadabra.arn
    role_arn               = aws_iam_role.firehose-log-stream-role.arn
    index_name             = "weblogs"
    index_rotation_period  = "OneDay"
    type_name              = "weblogs"
    s3_backup_mode         = "FailedDocumentsOnly"

    processing_configuration {
      enabled = "true"
      
      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_transform_weblogs.arn}:$LATEST"
        }
      }
    }
  }
}
