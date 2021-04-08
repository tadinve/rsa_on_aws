resource "aws_s3_bucket" "target-s3bucket" {
  bucket = "tf-${var.name_initials}-cadabra"
  acl    = "private"

  tags = local.common_tags
}

resource "aws_s3_bucket" "failed-logs-s3bucket" {
  bucket = "tf-${var.name_initials}-failed-http-logs"
  acl    = "private"

  tags = local.common_tags
}
