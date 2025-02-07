variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "eu-central-1"
  }

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
  }

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
  default     = "ami-09042b2f6d07d164a"
  }

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t2.micro"
  }

variable "key_name" {
  description = "The name of the EC2 key pair to use for the instance."
  type        = string
  default     = "nb-key-pair"
}

variable "aws_s3_bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
  default     = "nb-tf-state-management22"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the main subnet"
  default     = "10.0.1.0/24"
}

