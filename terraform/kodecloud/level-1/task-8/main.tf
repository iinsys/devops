# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-078359187648208a7"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

# Create AMI from the above instance
resource "aws_ami_from_instance" "xfusion_ec2_ami" {
  name               = "xfusion-ec2-ami"
  source_instance_id = aws_instance.ec2.id
  depends_on         = [aws_instance.ec2]

  tags = {
    Name = "xfusion-ec2-ami"
  }

  lifecycle {
    create_before_destroy = true
  }
}
