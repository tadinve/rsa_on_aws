
resource "aws_lambda_function" "lambda_process_cadabra_orders" {

  function_name = "tf-lambda-to-dynamo"
  role          = aws_iam_role.iam_for_lambda.arn
  #handler = python script file name . entry point function name
  handler       = "lambda_write_to_dynamodb.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  source_code_hash = filebase64sha256("lambda_write_to_dynamodb.zip")
  filename         = "lambda_write_to_dynamodb.zip"
  runtime          = "python3.7"

  tags = local.common_tags
}

# Attaching Kinesis data stream to trigger Lambda function
resource "aws_lambda_event_source_mapping" "cadabra_order_lambda_trigger" {

  event_source_arn  = aws_kinesis_stream.kinesis_cadabra_orders.arn
  function_name     = aws_lambda_function.lambda_process_cadabra_orders.arn
  starting_position = "LATEST"
}
