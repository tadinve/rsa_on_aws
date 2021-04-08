resource "aws_elasticsearch_domain" "es-cadabra" {
    domain_name           = "cadabra"
    elasticsearch_version = "6.4"

    cluster_config {
        instance_type  = "m4.large.elasticsearch"
        instance_count = "1"
    }

    ebs_options {
        ebs_enabled = "true"
        volume_size = "10"
    }

}
