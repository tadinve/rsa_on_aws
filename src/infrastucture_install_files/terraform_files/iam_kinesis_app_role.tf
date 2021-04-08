resource "aws_iam_role" "iam_kinesis_app" {
  name = "tf-kinesis_app_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "kinesisanalytics.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "kinesis_app_read_write_policy" {
  name = "tf-kinesis_app_read_write_policy"
  role = aws_iam_role.iam_kinesis_app.id

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
       {
            "Effect": "Allow",
            "Action": "kinesis:*",
            "Resource": "*"
       }
    ]
}
EOF
}
