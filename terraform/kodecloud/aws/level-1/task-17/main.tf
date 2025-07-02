# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_dynamodb_table" "datacenter_users" {
  name           = "datacenter-users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "datacenter_id"

  attribute {
    name = "datacenter_id"
    type = "S"
  }

  tags = {
    Name = "datacenter-users"
  }
}
