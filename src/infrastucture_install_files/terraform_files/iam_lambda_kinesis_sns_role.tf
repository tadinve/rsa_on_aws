resource "aws_iam_role" "iam_for_lambda_kinesis_sns" {
  name = "tf-lambda_kinesis_sns_role"
  tags = local.common_tags

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

resource "aws_iam_role_policy" "lambda_read_kinesis_write_sns_policy" {
  name = "tf-lambda_kinesis_sns_policy"
  role = aws_iam_role.iam_for_lambda_kinesis_sns.id

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
            "Action": "sns:*",
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
        },
        {
            "Effect": "Allow",
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
}
