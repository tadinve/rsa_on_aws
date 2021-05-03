resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_load_to_redshift.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.redshift_stage_s3bucket.arn 
}

resource "aws_lambda_function" "lambda_load_to_redshift" {

  function_name = "tf-lambda-load-redshift"
  role          = aws_iam_role.iam_lambda_redshift_role.arn
  #handler = python script file name . entry point function name
  handler       = "lambda_load_csv_to_redshift.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  source_code_hash = filebase64sha256("lambda_load_csv_to_redshift.zip")
  filename         = "lambda_load_csv_to_redshift.zip"
  runtime          = "python3.7"
  timeout          = 300

  environment {
    variables = {
      RS_ENDPOINT = data.aws_redshift_cluster.redshift_cluster.endpoint
      RS_USER     = data.aws_redshift_cluster.redshift_cluster.master_username
      RS_PWD      = var.redshift_password
      REGION      = var.user_region
      ROLE_ARN    = aws_iam_role.redshift_role.arn
    }
  }

  tags = local.common_tags
}
