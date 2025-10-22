# AWS Provider configuration is handled by existing provider.tf

# SNS Topic (already created)
resource "aws_sns_topic" "sns_topic" {
  name = "devops-sns-topic"

  tags = {
    Name = "devops-sns-topic"
  }
}

# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get subnet in the default VPC
data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  default_for_az    = true
}

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Create Security Group for EC2
resource "aws_security_group" "devops_sg" {
  name_prefix = "devops-sg"
  description = "Security group for devops EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  # Allow SSH from anywhere (optional)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-sg"
  }
}

# Create EC2 Instance
resource "aws_instance" "devops_ec2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "devops-ec2"
  }
}

# Create CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name          = "devops-alarm"
  alarm_description   = "Alarm when CPU exceeds 90%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = aws_instance.devops_ec2.id
  }

  alarm_actions = [aws_sns_topic.sns_topic.arn]

  tags = {
    Name = "devops-alarm"
  }
}
