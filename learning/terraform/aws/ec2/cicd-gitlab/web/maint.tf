#ec2

resource "aws_instance" "server" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  subnet_id = var.sn
  security_groups = [var.sg]

  tags = {
    Name = "myserver"
  }
}
