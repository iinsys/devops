provider "aws" {
  region = "us-east-1" # Change this to your desired region
}


# EC2 Instance
resource "aws_instance" "wordpress" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = module.vpc.public_subnets[0]

  security_groups = [aws_security_group.ec2_sg.id]

  user_data = file("scripts/user_data.sh")

  tags = {
    Name = "WordPress-Instance"
  }
}

# RDS MySQL
resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "Private-Subnet-Group"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  db_name                 = var.db_name   
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.private_subnet_group.name
}
