# provider "aws" {
#   region = "us-east-1"
# }

# Create the CloudWatch Log Group
resource "aws_cloudwatch_log_group" "datacenter_log_group" {
  name = "datacenter-log-group"

  tags = {
    Name = "datacenter-log-group"
  }
}

# Create the CloudWatch Log Stream
resource "aws_cloudwatch_log_stream" "datacenter_log_stream" {
  name           = "datacenter-log-stream"
  log_group_name = aws_cloudwatch_log_group.datacenter_log_group.name
}
