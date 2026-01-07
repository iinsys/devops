# Day 37 – EC2 to S3 Access Using IAM Role (AWS CLI)

> Tell me and I forget. Teach me and I remember. Involve me and I learn.
>
> – Benjamin Franklin

## Task Description

The Nautilus DevOps team needs to set up an application on an EC2 instance to interact with an S3 bucket for storing and retrieving data. To achieve this, the team must create a private S3 bucket, set appropriate IAM policies and roles, and test the application functionality.

### Task:

**EC2 Instance Setup:**
- An instance named `datacenter-ec2` already exists.
- The instance requires access to an S3 bucket.

**Setup SSH Keys:**
- Create new SSH key pair (id_rsa and id_rsa.pub) on the aws-client host and add the public key to the root user's authorized keys on the EC2 instance.

**Create a Private S3 Bucket:**
- Name the bucket `datacenter-s3-22727`.
- Ensure the bucket is private.

**Create an IAM Policy and Role:**
- Create an IAM policy allowing `s3:PutObject`, `s3:ListBucket`, and `s3:GetObject` access to `datacenter-s3-22727`.
- Create an IAM role named `datacenter-role`.
- Attach the policy to the IAM role.
- Attach this role to the `datacenter-ec2` instance.

**Test the Access:**
- SSH into the EC2 instance and upload a file to S3.
- List the uploaded file.

## Requirements

| Requirement              | Value                      |
|-------------------------|----------------------------|
| Region                  | `us-east-1`                |
| EC2 Instance Name       | `datacenter-ec2`           |
| S3 Bucket Name          | `datacenter-s3-22727`      |
| IAM Role Name           | `datacenter-role`          |
| IAM Policy Name         | `datacenter-s3-policy`     |
| Instance Profile Name   | `datacenter-instance-profile` |
| Access Method           | IAM Role (not access keys) |
| S3 Bucket Access        | Private                    |

## Solution (Using AWS CLI)

### Environment Setup (aws-client)

```bash
REGION="us-east-1"

EC2_NAME="datacenter-ec2"
ROLE_NAME="datacenter-role"
POLICY_NAME="datacenter-s3-policy"
PROFILE_NAME="datacenter-instance-profile"

BUCKET_NAME="datacenter-s3-22727"
```

### Step 1: Create SSH Key on aws-client

```bash
mkdir -p /root/.ssh
chmod 700 /root/.ssh

ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""
```

Verify:

```bash
ls -l /root/.ssh/
```

### Step 2: Add Public Key to EC2 (Inbound SSH Access)

#### 2.1 Get EC2 Public IP

```bash
EC2_PUBLIC_IP=$(aws ec2 describe-instances \
  --filters Name=tag:Name,Values=$EC2_NAME \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text \
  --region $REGION)

echo $EC2_PUBLIC_IP
```

#### 2.2 Add Inbound Rule (Port 22)

```bash
EC2_SG_ID=$(aws ec2 describe-instances \
  --filters Name=tag:Name,Values=$EC2_NAME \
  --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" \
  --output text \
  --region $REGION)

aws ec2 authorize-security-group-ingress \
  --group-id $EC2_SG_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0 \
  --region $REGION
```

### Step 3: Copy SSH Key to EC2

```bash
scp /root/.ssh/id_rsa.pub ubuntu@$EC2_PUBLIC_IP:/tmp/id_rsa.pub
```

SSH in:

```bash
ssh ubuntu@$EC2_PUBLIC_IP
```

On EC2:

```bash
sudo su -
mkdir -p /root/.ssh
chmod 700 /root/.ssh

cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys
```

Exit EC2.

### Step 4: Create Private S3 Bucket

```bash
aws s3api create-bucket \
  --bucket $BUCKET_NAME \
  --region $REGION
```

Ensure private access (default, but enforced):

```bash
aws s3api put-public-access-block \
  --bucket $BUCKET_NAME \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true \
  --region $REGION
```

### Step 5: Create IAM Policy

```bash
cat > s3-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::$BUCKET_NAME",
        "arn:aws:s3:::$BUCKET_NAME/*"
      ]
    }
  ]
}
EOF
```

Create policy:

```bash
POLICY_ARN=$(aws iam create-policy \
  --policy-name $POLICY_NAME \
  --policy-document file://s3-policy.json \
  --query Policy.Arn \
  --output text)

echo $POLICY_ARN
```

### Step 6: Create IAM Role

```bash
cat > trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
```

Create role:

```bash
aws iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://trust-policy.json
```

Attach policy:

```bash
aws iam attach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn $POLICY_ARN
```

### Step 7: Create Instance Profile and Attach Role

```bash
aws iam create-instance-profile \
  --instance-profile-name $PROFILE_NAME
```

Add role:

```bash
aws iam add-role-to-instance-profile \
  --instance-profile-name $PROFILE_NAME \
  --role-name $ROLE_NAME
```

### Step 8: Attach IAM Role to EC2

```bash
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters Name=tag:Name,Values=$EC2_NAME \
  --query "Reservations[0].Instances[0].InstanceId" \
  --output text \
  --region $REGION)

echo $INSTANCE_ID
```

Attach profile:

```bash
aws ec2 associate-iam-instance-profile \
  --instance-id $INSTANCE_ID \
  --iam-instance-profile Name=$PROFILE_NAME \
  --region $REGION
```

Wait 30–60 seconds for credentials to propagate.

### Step 9: Test S3 Access from EC2

SSH back in:

```bash
ssh root@$EC2_PUBLIC_IP
```

Create test file:

```bash
echo "Hello from datacenter EC2" > test.txt
```

Upload:

```bash
aws s3 cp test.txt s3://datacenter-s3-22727/
```

List bucket:

```bash
aws s3 ls s3://datacenter-s3-22727/
```

Expected Output: `test.txt`

## Task Completed



