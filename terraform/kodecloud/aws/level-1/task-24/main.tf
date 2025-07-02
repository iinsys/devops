# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_secretsmanager_secret" "datacenter_secret" {
  name = "datacenter-secret"

  tags = {
    Name = "datacenter-secret"
  }
}

resource "aws_secretsmanager_secret_version" "datacenter_secret_value" {
  secret_id     = aws_secretsmanager_secret.datacenter_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
  })
}
