
resource "aws_glue_catalog_database" "glue_db" {
  name = "tf-cadabra_glue"
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.glue_db.name
  name          = "tf-cadabra_crawler"
  role          = aws_iam_role.glue_role.arn

  tags = merge(
    local.common_tags,
    map(
      "Additional", "InfoHere",
      "More", "DetailsHere"
    )
  )

  s3_target {
    path = "s3://${aws_s3_bucket.target-s3bucket.bucket}/SalesTransactions/"
  }
}
