resource "aws_s3_bucket" "redshift_stage_s3bucket" {
  bucket = "tf-${var.name_initials}-redshift-stage-sales"
  acl    = "private"
}

resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  bucket = aws_s3_bucket.redshift_stage_s3bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_load_to_redshift.arn
    events              = ["s3:ObjectCreated:Put"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
