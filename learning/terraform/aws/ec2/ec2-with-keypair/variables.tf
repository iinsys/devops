variable "aws_key_name" {
  description = "The name of the AWS Key Pair to use"
  type        = string
  default     = "nb-key-pair"
}

variable "aws_ami_image" {
  description = "The AWS AMI to use"
  type        = string
  default     = "ami-09042b2f6d07d164a"
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "aws_instance_type" {
  description = "The AWS instance type to use"
  type        = string
  default     = "t2.micro"
}
