# Day 22 – EC2 Secure Access Setup (AWS CLI)

> Success doesn't come to you, you go to it.
>
> – Marva Collins

## Task Description

The Nautilus DevOps team needs to set up a new EC2 instance that can be accessed securely from their landing host (`aws-client`). The instance should be of type `t2.micro` and named `nautilus-ec2`. A new SSH key should be created on the aws-client host under the `/root/.ssh/` folder, if it doesn't already exist. This key should then be added to the root user's authorised keys on the EC2 instance, allowing passwordless SSH access from the aws-client host.

**Notes:**
- Create the resources only in `us-east-1`
- AWS CLI is used
- Commands are executed from the aws-client host

## Solution (Using AWS CLI)

### Step 1: Set required variables

```bash
EC2_NAME="nautilus-ec2"
EC2_TYPE="t2.micro"
REGION="us-east-1"
KEY_NAME="nautilus-ec2-key"
```

### Step 2: Create SSH key on aws-client (if not already present)

```bash
ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""
```

If the key already exists, do not overwrite it.

### Step 3: Import SSH public key into AWS as a Key Pair

```bash
aws ec2 import-key-pair \
  --key-name "$KEY_NAME" \
  --public-key-material fileb:///root/.ssh/id_rsa.pub \
  --region "$REGION"
```

### Step 4: Fetch Ubuntu AMI ID (latest Ubuntu 22.04)

```bash
AMI_ID=$(aws ec2 describe-images \
  --region "$REGION" \
  --owners 099720109477 \
  --filters \
    "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
    "Name=state,Values=available" \
  --query "sort_by(Images, &CreationDate)[-1].ImageId" \
  --output text)

echo "AMI ID: $AMI_ID"
```

### Step 5: Launch EC2 instance

```bash
INSTANCE_ID=$(aws ec2 run-instances \
  --region "$REGION" \
  --image-id "$AMI_ID" \
  --instance-type "$EC2_TYPE" \
  --key-name "$KEY_NAME" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$EC2_NAME}]" \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Instance ID: $INSTANCE_ID"
```

### Step 6: Wait until the instance is running

```bash
aws ec2 wait instance-running \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION"
```

### Step 7: Get default security group of the instance

```bash
VPC_ID=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].VpcId" \
  --output text)

SG_ID=$(aws ec2 describe-security-groups \
  --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=default" \
  --query "SecurityGroups[0].GroupId" \
  --output text)

echo "Default SG ID: $SG_ID"
```

### Step 8: Ensure SSH (port 22) access is allowed

```bash
aws ec2 authorize-security-group-ingress \
  --group-id "$SG_ID" \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

### Step 9: Get the public IP of the instance

```bash
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "Public IP: $PUBLIC_IP"
```

### Step 10: SSH into the instance as ubuntu user

```bash
ssh ubuntu@$PUBLIC_IP
```

### Step 11: Enable passwordless SSH for root user

Inside the EC2 instance:

```bash
sudo -i
mkdir -p /root/.ssh
cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
exit
exit
```

### Step 12: Verify passwordless root access from aws-client

```bash
ssh root@$PUBLIC_IP
```

