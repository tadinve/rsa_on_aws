resource "aws_lambda_function" "lambda_transform_weblogs" {

  function_name    = "tf-transform_weblogs"
  role             = aws_iam_role.iam_lambda_weblog_deliverystream.arn
  #handler = nodejs script file name . entry point function name
  handler          = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  source_code_hash = filebase64sha256("index.zip")
  filename         = "index.zip" 

  runtime          = "nodejs10.x"
  timeout          = 60

}
