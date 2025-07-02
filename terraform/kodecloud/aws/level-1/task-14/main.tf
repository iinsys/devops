# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_iam_user" "ravi" {
  name = "iamuser_ravi"
  tags = {
    Name = "iamuser_ravi"
  }
}
