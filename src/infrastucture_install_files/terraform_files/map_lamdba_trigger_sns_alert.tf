resource "aws_lambda_event_source_mapping" "map_alerting_lambda_event_source" {
  
  event_source_arn  = aws_kinesis_stream.kinesis_order_ratealarms.arn
  function_name     = aws_lambda_function.lambda_process_trans_ratealarms.arn
  starting_position = "LATEST"
}
