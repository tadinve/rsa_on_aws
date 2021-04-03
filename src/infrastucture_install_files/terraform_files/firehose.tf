resource "aws_kinesis_firehose_delivery_stream" "BatchSales" {
  name        = "tf-cadabra_batch_sales"
  destination = "s3"
 
   tags = merge(
    local.common_tags,
    map(
      "Additional", "InfoHere",
      "More", "DetailsHere"
    )
  )

  s3_configuration {
    role_arn        = aws_iam_role.firehose-stream-role.arn
    bucket_arn      = aws_s3_bucket.target-s3bucket.arn
    prefix          = "SalesTransactions/"
    buffer_size     = 5
    buffer_interval = 60
  }
}