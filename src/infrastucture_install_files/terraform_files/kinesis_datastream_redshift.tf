resource "aws_kinesis_stream" "redshift-datastream" {
  name             = "tf-redshift-datastream"
  shard_count      = 1
  retention_period = 24

  tags = local.common_tags
}
