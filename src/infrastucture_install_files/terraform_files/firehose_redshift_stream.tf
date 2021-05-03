#This is an attempt to use lambda instead of a direct firehose destination with redshift
resource "aws_kinesis_firehose_delivery_stream" "redshift-deliverystream" {
  name        = "tf-redshift-deliverystream"
  destination = "s3"
 
  s3_configuration {
    role_arn        = aws_iam_role.firehose-stream-role.arn
    bucket_arn      = aws_s3_bucket.redshift_stage_s3bucket.arn
    buffer_size     = 5
    buffer_interval = 60
  }

  kinesis_source_configuration {
      kinesis_stream_arn = aws_kinesis_stream.redshift-datastream.arn
      role_arn           = aws_iam_role.firehose-stream-role.arn
  }

  tags = local.common_tags
}
