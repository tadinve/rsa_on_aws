resource "aws_iam_role" "iam_lambda_weblog_deliverystream" {
  name = "tf-lambda_weblog_deliverystream_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_weblog_deliverystream_policy" {
  name = "tf-lambda_weblog_deliverystream_policy"
  role = aws_iam_role.iam_lambda_weblog_deliverystream.id

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "kinesis:*",
            "Resource": "*"
        },
	      {
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "lambda:*",
            "Resource": "*"
        }
    ]
}
EOF
}
