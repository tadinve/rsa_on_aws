resource "aws_iam_role" "glue_role" {
  name = "tf-glue_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = local.common_tags
}

resource "aws_iam_role_policy" "glue_role_policy" {
  name = "tf-glue_role_policy"
  role = aws_iam_role.glue_role.id

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

# Can't tag policy using Terraform
}