# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_eip" "nautilus_eip" {

  tags = {
    Name = "nautilus-eip"
  }
}
