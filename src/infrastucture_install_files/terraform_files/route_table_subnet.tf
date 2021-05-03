data "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = "tf-redshift-cluster"
  depends_on = [
    aws_redshift_cluster.redshift-cadabra
  ]
}

data "aws_vpc" "default_vpc" {
  id = data.aws_redshift_cluster.redshift_cluster.vpc_id
}

data "aws_internet_gateway" "default_ig" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_redshift_cluster.redshift_cluster.vpc_id]
  }
}

resource "aws_route" "open_ipv4_route" {
    route_table_id = data.aws_vpc.default_vpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default_ig.internet_gateway_id
}

resource "aws_route" "open_ipv6_route" {
    route_table_id = data.aws_vpc.default_vpc.main_route_table_id
    destination_ipv6_cidr_block = "::/0"
    gateway_id = data.aws_internet_gateway.default_ig.internet_gateway_id
}
