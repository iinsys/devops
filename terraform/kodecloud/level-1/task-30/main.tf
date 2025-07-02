# EC2 instance for future use
# To provision again, uncomment the resource block

resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-17e2b5b0fb6559645"
  ]

  tags = {
    Name = "devops-ec2"
  }
}
