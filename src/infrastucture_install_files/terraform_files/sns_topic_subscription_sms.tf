resource "aws_sns_topic" "sns_topic" {
  name = "tf-cadabra_alarms"
  tags = local.common_tags
}

resource "aws_sns_topic_subscription" "sms_subscription_target" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sms"
  endpoint  = var.user_phone
}


