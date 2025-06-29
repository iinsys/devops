# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"  # Changed from t2.micro to t2.nano
  subnet_id     = ""         # (Assumes this will be filled or already handled)

  vpc_security_group_ids = [
    "sg-25ace9809404d1dc4"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}
