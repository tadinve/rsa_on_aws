resource "aws_iam_role" "firehose-log-stream-role" {
  name = "firehose-log-stream-role"
  tags = local.common_tags

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "firehose.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}


resource "aws_iam_role_policy" "firehose-log-stream-policy" {
  name = "firehose-log-stream-policy"
  role = aws_iam_role.firehose-log-stream-role.id

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
            "Action": "s3:*",
            "Resource": "*"
        },
	      {
            "Effect": "Allow",
            "Action": "lambda:*",
            "Resource": "*"
        },
	      {
            "Effect": "Allow",
            "Action": "es:*",
            "Resource": "*"
        }
    ]
}
EOF
}
