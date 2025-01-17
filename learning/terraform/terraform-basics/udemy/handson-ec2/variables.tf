# Define a variable for the AWS region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# Define a variable for the key pair name
variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "auto-generated-key"
}

# aws access key
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

# aws secret key
variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

# aws ami for instance
variable "aws_ami" {
  description = "AWS ami for instance"
  type        = string
  default     = "ami-03cea216f9d507835"
}

# aws instance type
variable "aws_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro"
}