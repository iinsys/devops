# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_opensearch_domain" "xfusion_es" {
  domain_name           = "xfusion-es"

  engine_version        = "OpenSearch_2.11"

  cluster_config {
    instance_type        = "t3.small.search"
    instance_count       = 1
    zone_awareness_enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }

  access_policies = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "es:*",
        "Resource": "arn:aws:es:us-east-1:*:domain/xfusion-es/*"
      }
    ]
  })

  tags = {
    Name = "xfusion-es"
  }
}
