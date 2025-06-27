# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_cloudformation_stack" "devops_stack" {
  name          = "devops-stack"
  template_body = <<EOF
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "DevOpsBucket": {
      "Type": "AWS::S3::Bucket",
      "Properties": {
        "BucketName": "devops-bucket-6500",
        "VersioningConfiguration": {
          "Status": "Enabled"
        }
      }
    }
  }
}
EOF
}
