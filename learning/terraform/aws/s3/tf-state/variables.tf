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

variable "vpc_name" {
    type = string
    description = "VPC name"
}

variable "vpc_cidr" {
    type        = string
    description = "CIDR block for the VPC"
    default     = "172.31.0.0/16"
}