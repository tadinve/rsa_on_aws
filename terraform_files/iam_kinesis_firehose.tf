
resource "aws_iam_role" "firehose-stream-role" {
  name = "tf-cd-firehose-stream-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid = ""
         Principal = {
          Service = "firehose.amazonaws.com"
        },
      }
    ]
  })

  tags = local.common_tags
}


resource "aws_iam_role_policy" "firehose-stream-policy" {
  name = "tf-cd-firehose-stream-policy"
  role = aws_iam_role.firehose-stream-role.id

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
        }
    ]
}
EOF

# Can't tag policy using Terraform
}