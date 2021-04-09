
resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_role"

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

  tags = local.common_tags
}

resource "aws_iam_role_policy" "lambda_read_write_policy" {
  name = "lambda_read_write_policy"
  role = aws_iam_role.iam_for_lambda.id

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
            "Action": "dynamodb:*",
            "Resource": "*"
        },
	      {
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "*"
        }
    ]
}
EOF
}