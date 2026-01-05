# Day 30 – Enable Internet Access for Private EC2 Using a NAT Instance

> You don't learn to walk by following rules. You learn by doing, and falling over.
>
> – Richard Branson

## Task Description

The Nautilus DevOps team is tasked with enabling internet access for an EC2 instance running in a private subnet. This instance should be able to upload a test file to a public S3 bucket once it can access the internet. To minimize costs, the team has decided to use a NAT Instance instead of a NAT Gateway.

### Existing Environment

- A VPC named `datacenter-priv-vpc` and a private subnet named `datacenter-priv-subnet` already exist
- An EC2 instance named `datacenter-priv-ec2` is running in the private subnet
- The EC2 instance has a cron job that uploads `datacenter-test.txt` to the S3 bucket `datacenter-nat-29854` every minute
- Upload will only succeed once internet access is established

### Your Tasks

- Create a public subnet named `datacenter-pub-subnet` in the existing VPC
- Launch a NAT Instance using Amazon Linux 2, named `datacenter-nat-instance`, in the public subnet
- Configure routing so the private EC2 instance can access the internet
- Verify that `datacenter-test.txt` appears in the S3 bucket `datacenter-nat-29854`

### Requirements

| Requirement           | Value                        |
|----------------------|------------------------------|
| VPC Name             | `datacenter-priv-vpc`        |
| Private Subnet       | `datacenter-priv-subnet`     |
| Public Subnet        | `datacenter-pub-subnet`      |
| NAT Instance Name    | `datacenter-nat-instance`    |
| S3 Bucket            | `datacenter-nat-29854`       |
| Region               | `us-east-1`                  |

## Solution (Using AWS CLI)

### Step 1: Set Variables

```bash
VPC_NAME="datacenter-priv-vpc"
PRIV_SUBNET_NAME="datacenter-priv-subnet"
PUB_SUBNET_NAME="datacenter-pub-subnet"
NAT_INSTANCE_NAME="datacenter-nat-instance"
S3_BUCKET="datacenter-nat-29854"
REGION="us-east-1"
```

### Step 2: Get VPC and Private Subnet Details

```bash
VPC_ID=$(aws ec2 describe-vpcs \
  --filters Name=tag:Name,Values="$VPC_NAME" \
  --query "Vpcs[0].VpcId" \
  --output text)

PRIV_SUBNET_ID=$(aws ec2 describe-subnets \
  --filters Name=tag:Name,Values="$PRIV_SUBNET_NAME" \
  --query "Subnets[0].SubnetId" \
  --output text)

VPC_CIDR=$(aws ec2 describe-vpcs \
  --vpc-ids "$VPC_ID" \
  --query "Vpcs[0].CidrBlock" \
  --output text)
```

### Step 3: Create Public Subnet (Non-overlapping CIDR)

Important: CIDR must be inside the VPC range but not overlap private subnet.

```bash
PUB_SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id "$VPC_ID" \
  --cidr-block 10.1.2.0/24 \
  --availability-zone us-east-1a \
  --query "Subnet.SubnetId" \
  --output text)

aws ec2 create-tags \
  --resources "$PUB_SUBNET_ID" \
  --tags Key=Name,Value="$PUB_SUBNET_NAME"
```

### Step 4: Enable Auto-Assign Public IP (Critical)

```bash
aws ec2 modify-subnet-attribute \
  --subnet-id "$PUB_SUBNET_ID" \
  --map-public-ip-on-launch
```

### Step 5: Ensure Internet Gateway Exists

```bash
IGW_ID=$(aws ec2 describe-internet-gateways \
  --filters Name=attachment.vpc-id,Values="$VPC_ID" \
  --query "InternetGateways[0].InternetGatewayId" \
  --output text)
```

If empty, create and attach:

```bash
IGW_ID=$(aws ec2 create-internet-gateway \
  --query "InternetGateway.InternetGatewayId" \
  --output text)

aws ec2 attach-internet-gateway \
  --internet-gateway-id "$IGW_ID" \
  --vpc-id "$VPC_ID"
```

### Step 6: Create Route Table for Public Subnet

```bash
PUB_RT_ID=$(aws ec2 create-route-table \
  --vpc-id "$VPC_ID" \
  --query "RouteTable.RouteTableId" \
  --output text)

aws ec2 create-route \
  --route-table-id "$PUB_RT_ID" \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id "$IGW_ID"

aws ec2 associate-route-table \
  --route-table-id "$PUB_RT_ID" \
  --subnet-id "$PUB_SUBNET_ID"
```

### Step 7: Create Security Group for NAT Instance

```bash
NAT_SG_ID=$(aws ec2 create-security-group \
  --group-name datacenter-nat-sg \
  --description "NAT instance security group" \
  --vpc-id "$VPC_ID" \
  --query "GroupId" \
  --output text)

aws ec2 authorize-security-group-ingress \
  --group-id "$NAT_SG_ID" \
  --protocol -1 \
  --cidr "$VPC_CIDR"
```

### Step 8: Launch NAT Instance (Amazon Linux 2)

```bash
AMI_ID=$(aws ssm get-parameters \
  --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
  --query "Parameters[0].Value" \
  --output text)

USER_DATA='#!/bin/bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -j ACCEPT
'

NAT_INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --instance-type t2.micro \
  --subnet-id "$PUB_SUBNET_ID" \
  --security-group-ids "$NAT_SG_ID" \
  --associate-public-ip-address \
  --user-data "$USER_DATA" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NAT_INSTANCE_NAME}]" \
  --query "Instances[0].InstanceId" \
  --output text)
```

### Step 9: Disable Source/Destination Check (Mandatory)

```bash
aws ec2 modify-instance-attribute \
  --instance-id "$NAT_INSTANCE_ID" \
  --no-source-dest-check
```

### Step 10: Update Private Route Table

```bash
PRIV_RT_ID=$(aws ec2 describe-route-tables \
  --filters Name=association.subnet-id,Values="$PRIV_SUBNET_ID" \
  --query "RouteTables[0].RouteTableId" \
  --output text)

aws ec2 create-route \
  --route-table-id "$PRIV_RT_ID" \
  --destination-cidr-block 0.0.0.0/0 \
  --instance-id "$NAT_INSTANCE_ID"
```

## Verification

```bash
aws s3 ls s3://datacenter-nat-29854/
```

You should now see: `datacenter-test.txt`

