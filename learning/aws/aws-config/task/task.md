# EC2 Custom Compliance Pack Implementation - eu-central-1
> File: learning/aws/aws-config/task.md

## Overview
This guide implements a custom compliance pack for EC2 instances that:
- Checks for required tags
- Verifies owner information
- Sets up email/Slack notifications
- Operates in eu-central-1 region

## Prerequisites
```bash
# Set environment variables
export AWS_DEFAULT_REGION=eu-central-1
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
```

# Custom EC2 Compliance Pack Implementation via AWS Console
> File: learning/aws/aws-config/console-implementation.md

## Step 1: Create Conformance Pack Template File

First, create a file named `ec2-tag-compliance.yaml` with the following content:

```yaml
Resources:
  EC2TagComplianceRule:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-required-tags-check
      Description: "Checks if EC2 instances have required tags and owner information"
      InputParameters:
        tag1Key: "Project"
        tag1Value: "ProjectA,ProjectB,ProjectC"
        tag2Key: "Owner"
        tag3Key: "Environment"
        tag3Value: "Production,Development,Staging"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::Instance"
      Source:
        Owner: AWS
        SourceIdentifier: REQUIRED_TAGS

  NotificationTopic:
    Type: AWS::SNS::Topic
    Properties:
      TopicName: ec2-compliance-notifications
      DisplayName: "EC2 Compliance Notifications"




Lamda fuction with pythong that will check if all resoureces has tags and if not it will create that tag with the owner
Owner:: then the ownername