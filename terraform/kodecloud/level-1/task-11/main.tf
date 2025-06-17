# provider "aws" {
#   region = "us-east-1"
# }

# Existing EC2 instance (assume you already have this)
resource "aws_instance" "example" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  tags = {
    Name = "example-instance"
  }
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "datacenter_alarm" {
  alarm_name          = "datacenter-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300                      # 5 minutes
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers if CPU > 80%"
  actions_enabled     = false                    # No action (SNS) for now

  dimensions = {
    InstanceId = aws_instance.example.id
  }
}
