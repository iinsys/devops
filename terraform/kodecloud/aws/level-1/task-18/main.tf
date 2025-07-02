# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_kinesis_stream" "devops_stream" {
  name             = "devops-stream"
  shard_count      = 1
  retention_period = 24

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = {
    Name = "devops-stream"
  }
}
