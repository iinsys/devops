# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_ssm_parameter" "datacenter_param" {
  name        = "datacenter-ssm-parameter"
  type        = "String"
  value       = "datacenter-value"
  description = "SSM parameter for datacenter"

  tags = {
    Name = "datacenter-ssm-parameter"
  }
}
