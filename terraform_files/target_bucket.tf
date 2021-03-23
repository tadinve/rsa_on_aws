resource "aws_s3_bucket" "target-s3bucket" {
  bucket = "tf-${var.name_initials}-cadabra"
  acl    = "private"

  tags = local.common_tags
}