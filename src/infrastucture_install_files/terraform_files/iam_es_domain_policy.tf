resource "aws_elasticsearch_domain_policy" "es-cadabra-policy" {
  domain_name = aws_elasticsearch_domain.es-cadabra.domain_name
  tags        = local.common_tags

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.es-cadabra.arn}/*",
            "Condition": {
                "IpAddress": {
                    "aws:SourceIp": ["${var.user_ipaddress}/32"]
                }
            }
        }
    ]
}
POLICIES
}
