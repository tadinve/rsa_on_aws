
resource "aws_kinesis_stream" "kinesis_cadabra_orders" {
  name             = "tf-order-stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = local.common_tags
}

#This is to trigger SNS alert
resource "aws_kinesis_stream" "kinesis_order_ratealarms" {
  name             = "tf-order-ratealarm"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = local.common_tags 
}
