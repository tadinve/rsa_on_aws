resource "aws_redshift_cluster" "redshift-cadabra" {
  cluster_identifier  = "tf-redshift-cluster"
  database_name       = "dev"
  master_username     = var.redshift_user
  master_password     = var.redshift_password
  node_type           = "dc2.large"
  cluster_type        = "single-node"
  skip_final_snapshot = true
  iam_roles           = [aws_iam_role.redshift_role.arn]
}
