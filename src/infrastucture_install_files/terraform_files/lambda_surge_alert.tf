resource "aws_lambda_function" "lambda_process_trans_ratealarms" {

  function_name = "tf-surge-alerter"
  role          = aws_iam_role.iam_for_lambda_kinesis_sns.arn
  #handler = python script file name . entry point function name
  handler       = "lambda_surge_alert.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  source_code_hash = filebase64sha256("lambda_surge_alert.zip")
  filename         = "lambda_surge_alert.zip" 

  runtime = "python3.7"
  timeout = 60

  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.sns_topic.arn
    }
  }

  tags = local.common_tags
}
