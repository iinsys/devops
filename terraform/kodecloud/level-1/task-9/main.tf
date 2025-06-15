# provider "aws" {
#   region = "us-east-1" # Change to your desired AWS region
# }

resource "aws_ebs_volume" "nautilus_volume" {
  availability_zone = "us-east-1a"  # Use a valid AZ for your region
  size              = 2             # Size in GiB
  type              = "gp3"         # General Purpose SSD

  tags = {
    Name = "nautilus-volume"
  }
}
