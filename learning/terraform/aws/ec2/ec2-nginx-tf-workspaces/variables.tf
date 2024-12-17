variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "aws_region" {
  type = string
  description = "AWS region"
  default = "eu-central-1"
}

variable "key_name" {
    type = string
    description = "SSH key pair name"
    default = "auto-generated-key-pair"
}

variable "instance_type" {
  type = map(any)
  description = "EC2 instance type"
  default = {
     default = "t2.nano"
     dev = "t2.micro"
     test = "t2.small"
  }
}

variable "ami_id" {
  type = string
  description = "AMI ID for the EC2 instance"
  default = "ami-09042b2f6d07d164a"
}
