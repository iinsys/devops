variable "aws_region" {
  type = string
  description = "AWS region"
  default = "eu-central-1"
}

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}


variable "bucket_name" {
  type = string
  description = "S3 bucket name"
  #default = "nb-hosting-bucket"
  
}