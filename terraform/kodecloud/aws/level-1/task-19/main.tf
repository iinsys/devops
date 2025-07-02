# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_sns_topic" "devops_notifications" {
  name = "devops-notifications"

  tags = {
    Name = "devops-notifications"
  }
}
