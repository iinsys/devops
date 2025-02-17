# EC2 Conformance Pack Guide - eu-central-1 Region

## Table of Contents
- [Prerequisites](#prerequisites)
- [Conformance Pack Template](#conformance-pack-template)
- [Step-by-Step Implementation](#step-by-step-implementation)
- [Monitoring and Maintenance](#monitoring-and-maintenance)

## Prerequisites

1. **Set up IAM Role**
```bash
# Create IAM role trust policy
cat << EOF > config-role-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

# Create the IAM role
aws iam create-role \
    --role-name AWSConfigRole \
    --assume-role-policy-document file://config-role-trust-policy.json

# Attach required policies
aws iam attach-role-policy \
    --role-name AWSConfigRole \
    --policy-arn arn:aws:iam::aws:policy/service-role/AWSConfigRole
```
Create S3 Bucket for Config
```bash
# Create bucket in eu-central-1
aws s3api create-bucket \
    --bucket config-bucket-${AWS_ACCOUNT_ID}-eu-central-1 \
    --region eu-central-1 \
    --create-bucket-configuration LocationConstraint=eu-central-1

# Enable bucket encryption
aws s3api put-bucket-encryption \
    --bucket config-bucket-${AWS_ACCOUNT_ID}-eu-central-1 \
    --server-side-encryption-configuration '{
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }
        ]
    }'
```
### Conformance Pack Template
Create a file named `ec2-conformance-pack.yaml`
```yaml
Resources:
  # Check if EC2 instances are EBS optimized
  EC2EBSOptimized:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-ebs-optimization-check
      Description: "Checks if EBS optimization is enabled for EC2 instances"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::Instance"
      Source:
        Owner: AWS
        SourceIdentifier: EC2_EBS_OPTIMIZATION_CHECK

  # Check for required instance tags
  RequiredTags:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-required-tags
      Description: "Checks if EC2 instances have required tags"
      InputParameters:
        tag1Key: "Environment"
        tag1Value: "Production,Development,Staging"
        tag2Key: "Owner"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::Instance"
      Source:
        Owner: AWS
        SourceIdentifier: REQUIRED_TAGS

  # Check for approved instance types
  EC2InstanceType:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-instance-type-check
      Description: "Checks if EC2 instances are of approved types"
      InputParameters:
        instanceType: "t3.micro,t3.small,t3.medium"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::Instance"
      Source:
        Owner: AWS
        SourceIdentifier: DESIRED_INSTANCE_TYPE

  # Check for encrypted volumes
  EC2EncryptedVolumes:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-encrypted-volumes
      Description: "Checks if EBS volumes attached to EC2 instances are encrypted"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::Volume"
      Source:
        Owner: AWS
        SourceIdentifier: ENCRYPTED_VOLUMES

  # Check for security group rules
  EC2SecurityGroupOpen:
    Type: AWS::Config::ConfigRule
    Properties:
      ConfigRuleName: ec2-security-group-open-check
      Description: "Checks for unrestricted security group rules"
      Scope:
        ComplianceResourceTypes:
          - "AWS::EC2::SecurityGroup"
      Source:
        Owner: AWS
        SourceIdentifier: INCOMING_SSH_DISABLED
```
### Step-by-Step Implementation
1. Step-by-Step Implementation
```bash
# Set region
export AWS_DEFAULT_REGION=eu-central-1

# Enable Config
aws configservice put-configuration-recorder \
    --configuration-recorder name=eu-central-1-recorder,roleARN=arn:aws:iam::${AWS_ACCOUNT_ID}:role/AWSConfigRole \
    --recording-group '{"allSupported":true,"includeGlobalResources":false}'

# Start recording
aws configservice start-configuration-recorder \
    --configuration-recorder-name eu-central-1-recorder
```
2. Deploy the Conformance Pack
```bash
# Upload template to S3
aws s3 cp ec2-conformance-pack.yaml \
    s3://config-bucket-${AWS_ACCOUNT_ID}-eu-central-1/

# Deploy conformance pack
aws configservice put-conformance-pack \ [[2]](https://docs.aws.amazon.com/config/latest/developerguide/conformance-pack-cli.html)
    --conformance-pack-name ec2-security-baseline \ [[3]](https://docs.aws.amazon.com/config/latest/developerguide/conformance-pack-organization-apis.html)
    --template-s3-uri s3://config-bucket-${AWS_ACCOUNT_ID}-eu-central-1/ec2-conformance-pack.yaml \
    --delivery-s3-bucket config-bucket-${AWS_ACCOUNT_ID}-eu-central-1
```
3. Verify Deployment
```bash
# Get overall compliance
aws configservice get-conformance-pack-compliance-summary \
    --conformance-pack-names ec2-security-baseline

# Get detailed compliance for specific rules
aws configservice get-compliance-details-by-config-rule \
    --config-rule-name ec2-required-tags
```
### Monitoring and Maintenance
1. Check Compliance Status
```bash
# Get overall compliance
aws configservice get-conformance-pack-compliance-summary \
    --conformance-pack-names ec2-security-baseline

# Get detailed compliance for specific rules
aws configservice get-compliance-details-by-config-rule \
    --config-rule-name ec2-required-tags
```
2. Set up Notifications
```bash
# Create SNS topic for notifications
aws sns create-topic --name config-notifications

# Create CloudWatch Events rule
aws events put-rule \
    --name ConfigComplianceChange \
    --event-pattern '{
        "source": ["aws.config"],
        "detail-type": ["Config Rules Compliance Change"]
    }'
```
3. Regular Maintenance Tasks
```bash
# List non-compliant resources
aws configservice get-compliance-details-by-config-rule \
    --config-rule-name ec2-encrypted-volumes \
    --compliance-types NON_COMPLIANT

# Update conformance pack
aws configservice put-conformance-pack \
    --conformance-pack-name ec2-security-baseline \
    --template-s3-uri s3://config-bucket-${AWS_ACCOUNT_ID}-eu-central-1/ec2-conformance-pack-updated.yaml \
    --delivery-s3-bucket config-bucket-${AWS_ACCOUNT_ID}-eu-central-1
```
### Remediation Actions
Add automatic remediation for non-compliant resources:
```yaml
# Add to ec2-conformance-pack.yaml
  EncryptedVolumesRemediation:
    Type: AWS::Config::RemediationConfiguration
    Properties:
      ConfigRuleName: ec2-encrypted-volumes
      TargetType: SSM_DOCUMENT
      TargetId: AWS-EncryptEBSVolume
      Parameters:
        VolumeId:
          ResourceValue:
            Value: RESOURCE_ID
```

## Best Practices Guide

### Resource Tagging Strategy

#### Mandatory Tags
- `Environment` - (e.g., Production, Development, Staging)
- `Owner` - Team or individual responsible
- `CostCenter` - For billing allocation
- `Project` - Associated project name
- `Application` - Application identifier

#### Implementation Example:
```yaml
RequiredTags:
  Type: AWS::Config::ConfigRule
  Properties:
    ConfigRuleName: required-tags-check
    Description: "Checks for mandatory resource tags"
    InputParameters:
      tag1Key: "Environment"
      tag1Value: "Production,Development,Staging"
      tag2Key: "Owner"
      tag3Key: "CostCenter"
    Scope:
      ComplianceResourceTypes:
        - "AWS::EC2::Instance"
        - "AWS::S3::Bucket"
        - "AWS::RDS::DBInstance"
    Source:
      Owner: AWS
      SourceIdentifier: REQUIRED_TAGS
```
**Compliance Monitoring:**
```bash
# Check tag compliance
aws configservice get-compliance-details-by-config-rule \
    --config-rule-name required-tags-check \
    --compliance-types NON_COMPLIANT
```
**Security Considerations**
1. Security Group Reviews
```yaml
SecurityGroupReview:
  Type: AWS::Config::ConfigRule
  Properties:
    ConfigRuleName: restricted-ssh
    Description: "Checks for restricted SSH access"
    Source:
      Owner: AWS
      SourceIdentifier: INCOMING_SSH_DISABLED
```
2. Encryption Verification
```yaml
EncryptionCheck:
  Type: AWS::Config::ConfigRule
  Properties:
    ConfigRuleName: encryption-check
    Description: "Verifies encryption on resources"
    Scope:
      ComplianceResourceTypes:
        - "AWS::EC2::Volume"
        - "AWS::RDS::DBInstance"
    Source:
      Owner: AWS
      SourceIdentifier: ENCRYPTED_VOLUMES
```
3. Instance Type Restrictions
```yaml
InstanceTypeCheck:
  Type: AWS::Config::ConfigRule
  Properties:
    ConfigRuleName: approved-instance-types
    Description: "Ensures only approved instance types are used"
    InputParameters:
      instanceType: "t3.micro,t3.small,t3.medium"
    Source:
      Owner: AWS
      SourceIdentifier: DESIRED_INSTANCE_TYPE
```
**Cost Management**
1. Resource Monitoring
```bash
# List unused EBS volumes
aws ec2 describe-volumes \
    --filters Name=status,Values=available

# List stopped instances
aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=stopped
```
2. Compliance Reporting
```bash
# Generate monthly compliance report
aws configservice get-aggregate-compliance-details-by-config-rule \
    --configuration-aggregator-name my-aggregator \
    --config-rule-name resource-utilization \
    --account-id ${AWS_ACCOUNT_ID} \
    --aws-region eu-central-1
```
**Operational Excellence**
1. Configuration Documentation
```yaml
# Example documentation in CloudFormation
Resources:
  ConfigurationDocument:
    Metadata:
      Documentation:
        Version: "1.0"
        Description: "Infrastructure configuration baseline"
        MaintenanceWindow: "Sunday 02:00-04:00 UTC"
        Owner: "Platform Team"
```
2. Automated Notifications
```yaml
NotificationSetup:
  Type: AWS::SNS::Topic
  Properties:
    TopicName: config-notifications
    Subscription:
      - Protocol: email
        Endpoint: team@example.com

ConfigAlarm:
  Type: AWS::CloudWatch::Alarm
  Properties:
    AlarmName: ConfigComplianceAlert
    ComparisonOperator: LessThanThreshold
    EvaluationPeriods: 1
    MetricName: ComplianceScore
    Namespace: AWS/Config
    Period: 300
    Threshold: 90
```
3. Change Management
```bash
# Track configuration changes
aws configservice get-resource-config-history \
    --resource-type AWS::EC2::Instance \
    --resource-id i-1234567890abcdef0

# Set up AWS Config recording
aws configservice start-configuration-recorder \
    --configuration-recorder-name default
```
Regular Maintenance Checklist
- Weekly security group rule review

- Monthly tag compliance audit

- Quarterly cost optimization review

- Bi-annual encryption verification

- Monthly unused resource cleanup

- Weekly compliance report review

- Daily configuration change monitoring

This guide provides:
- Complete setup instructions
- Region-specific configurations
- EC2-focused compliance rules
- Monitoring and maintenance procedures
- Remediation actions
- Best practices for ongoing management

The conformance pack includes rules for:
- EBS optimization
- Required tagging
- Instance type compliance
- Volume encryption
- Security group configuration

Would you like me to expand on any particular aspect or add additional rules to the conformance pack?
