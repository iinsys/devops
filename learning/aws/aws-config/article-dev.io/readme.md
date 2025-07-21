# AWS Config Conformance Packs: Hands-On with Terraform

In [Part 1](https://dev.to/bansikah/aws-config-automate-your-cloud-compliance-and-security-2n23), we explored the theory behind AWS Config and Conformance Packs — their purpose, benefits, and how they fit into your cloud governance strategy. In this second part, we'll get our hands dirty and walk through the process of enabling AWS Config and deploying a sample Conformance Pack using Terraform. Let’s automate your compliance the DevOps way!

---

## Prerequisites
- AWS account with permissions for AWS Config, S3, and CloudFormation
- Terraform installed ([Get started](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- AWS CLI installed and configured (`aws configure`)

---

## Step 1: Prepare Your Terraform Project
```bash
mkdir learn-terraform-conformance-packs
cd learn-terraform-conformance-packs
touch main.tf
```

---

## Step 2: Terraform Configuration

### **Option 1: Enable AWS Config and Deploy Conformance Pack**

Paste the following into your `main.tf` if you have **not** enabled AWS Config yet:

```hcl
# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Toggle for enabling AES256 encryption on the S3 bucket
variable "encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable AES256 encryption by default"
}

# Get current AWS region, account ID, and partition information
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

# IAM role for AWS Config service to assume
resource "aws_iam_role" "config_role" {
  name = "awsconfig-example"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "config.amazonaws.com" },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# Inline policy providing AWS Config permissions to record and deliver configuration data
resource "aws_iam_role_policy" "config_inline_policy" {
  name = "awsconfig-inline-policy"
  role = aws_iam_role.config_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "config:Put*",
          "config:Get*",
          "config:Describe*",
          "s3:PutObject",
          "s3:GetBucketAcl",
          "sns:Publish",
          "iam:GetRole",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach AWS-managed ReadOnlyAccess policy to allow read access across AWS resources
resource "aws_iam_role_policy_attachment" "read_only_policy_attach" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Create an S3 bucket to store AWS Config logs
resource "aws_s3_bucket" "new_config_bucket" {
  bucket        = "config-bucket-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  force_destroy = true
}

# Enable AES256 server-side encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.new_config_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 bucket policy granting AWS Config permission to write logs and enforcing SSL
resource "aws_s3_bucket_policy" "config_logging_policy" {
  bucket = aws_s3_bucket.new_config_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowBucketAcl",
      "Effect": "Allow",
      "Principal": { "Service": ["config.amazonaws.com"] },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.new_config_bucket.arn}",
      "Condition": { "Bool": { "aws:SecureTransport": "true" } }
    },
    {
      "Sid": "AllowConfigWriteAccess",
      "Effect": "Allow",
      "Principal": { "Service": ["config.amazonaws.com"] },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.new_config_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*",
      "Condition": {
        "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" },
        "Bool": { "aws:SecureTransport": "true" }
      }
    },
    {
      "Sid": "RequireSSL",
      "Effect": "Deny",
      "Principal": { "AWS": "*" },
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.new_config_bucket.arn}/*",
      "Condition": { "Bool": { "aws:SecureTransport": "false" } }
    }
  ]
}
POLICY
}

# Configuration recorder for AWS Config that tracks changes to supported resources
resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "config_recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported                  = true
    include_global_resource_types = true
  }
}

# Delivery channel for AWS Config to store configuration snapshots in the S3 bucket
resource "aws_config_delivery_channel" "config_channel" {
  s3_bucket_name = aws_s3_bucket.new_config_bucket.id
  depends_on     = [aws_config_configuration_recorder.config_recorder]
}

# Enable the configuration recorder
resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config_channel]
}

# Deploy AWS Config Conformance Pack to enforce best practices for S3 buckets
resource "aws_config_conformance_pack" "s3conformancepack" {
  name = "s3conformancepack"

  template_body = <<EOT
Resources:
  S3BucketPublicReadProhibited:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketPublicReadProhibited
      Description: Checks that your Amazon S3 buckets do not allow public read access.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_READ_PROHIBITED
      MaximumExecutionFrequency: Six_Hours
  S3BucketPublicWriteProhibited:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketPublicWriteProhibited
      Description: Checks that your Amazon S3 buckets do not allow public write access.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_WRITE_PROHIBITED
      MaximumExecutionFrequency: Six_Hours
  S3BucketReplicationEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketReplicationEnabled
      Description: Checks whether the Amazon S3 buckets have cross-region replication enabled.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_REPLICATION_ENABLED
  S3BucketSSLRequestsOnly:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketSSLRequestsOnly
      Description: Checks whether S3 buckets have policies that require requests to use Secure Socket Layer (SSL).
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SSL_REQUESTS_ONLY
  ServerSideEncryptionEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ServerSideEncryptionEnabled
      Description: Checks that your Amazon S3 bucket either has S3 default encryption enabled or that the S3 bucket policy explicitly denies put-object requests without server side encryption.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED
  S3BucketLoggingEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketLoggingEnabled
      Description: Checks whether logging is enabled for your S3 buckets.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_LOGGING_ENABLED
EOT

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

```

---

### **Option 2: Only Deploy Conformance Pack (If AWS Config is Already Enabled)**

If you already have AWS Config enabled, you can use a minimal `main.tf` like this:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_config_conformance_pack" "s3conformancepack" {
  name = "s3conformancepack"
  template_body = <<EOT
Resources:
  S3BucketPublicReadProhibited:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketPublicReadProhibited
      Description: Checks that your Amazon S3 buckets do not allow public read access.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_READ_PROHIBITED
      MaximumExecutionFrequency: Six_Hours
  S3BucketPublicWriteProhibited:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketPublicWriteProhibited
      Description: Checks that your Amazon S3 buckets do not allow public write access.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_WRITE_PROHIBITED
      MaximumExecutionFrequency: Six_Hours
  S3BucketReplicationEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketReplicationEnabled
      Description: Checks whether the Amazon S3 buckets have cross-region replication enabled.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_REPLICATION_ENABLED
  S3BucketSSLRequestsOnly:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketSSLRequestsOnly
      Description: Checks whether S3 buckets have policies that require requests to use Secure Socket Layer (SSL).
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SSL_REQUESTS_ONLY
  ServerSideEncryptionEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ServerSideEncryptionEnabled
      Description: Checks that your Amazon S3 bucket either has S3 default encryption enabled or that the S3 bucket policy explicitly denies put-object requests without server side encryption.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED
  S3BucketLoggingEnabled:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: S3BucketLoggingEnabled
      Description: Checks whether logging is enabled for your S3 buckets.
      Scope:
        ComplianceResourceTypes:
        - "AWS::S3::Bucket"
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_LOGGING_ENABLED
EOT
}
```

---

## Step 3: Initialize, Format, Validate, and Apply
```bash
terraform init
terraform fmt
terraform validate
terraform apply
```

- Enter your AWS region (e.g., `us-east-1`) when prompted.
- Type `yes` to confirm and apply the changes.

---

## Step 4: Verify Deployment
- Go to the AWS Console → Config → Conformance Packs
- You should see `s3conformancepack` deployed and active.

---

## Step 5: Clean Up
To remove all resources:
```bash
terraform destroy
```
Type `yes` when prompted to confirm destruction.

---

## References
- [AWS Config Conformance Packs](https://docs.aws.amazon.com/config/latest/developerguide/conformance-packs.html)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_conformance_pack)
- [AWS Blog: Deploy Conformance Packs with Terraform](https://aws.amazon.com/blogs/mt/how-to-deploy-aws-config-conformance-packs-using-terraform/)

---

**Congratulations!** You have automated AWS Config and Conformance Pack deployment using Terraform. This approach helps you enforce best practices and compliance at scale in your AWS environment.