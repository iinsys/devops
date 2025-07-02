terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
#   region = "us-west-2"
}
# This provider configuration uses the AWS provider to manage resources in the us-west-2 region.
# The version constraint ensures compatibility with AWS provider versions 3.x.
# The provider block specifies the AWS region where resources will be created.