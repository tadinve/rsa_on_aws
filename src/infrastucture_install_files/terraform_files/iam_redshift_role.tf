resource "aws_iam_role" "redshift_role" {
  name = "tf-redshift_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "redshift.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "redshift_role_policy" {
  name = "redshift_role_policy"
  role = aws_iam_role.redshift_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
	      {
            "Effect": "Allow",
            "Action": "S3:*",
            "Resource": "*"
        },
	      {
            "Effect": "Allow",
            "Action": "glue:*",
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
