# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_iam_group" "mark_group" {
  name = "iamgroup_mark"
}
