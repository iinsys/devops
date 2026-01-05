# Day 27 – Create Public VPC, Subnet, and EC2 Instance

> I can and I will. Watch me.
>
> – Carrie Green

## Task Description

The Nautilus DevOps Team needs to set up a public VPC to host internet-facing services.
This VPC must include a public subnet with automatic public IP assignment and an EC2 instance that is accessible via SSH from the internet.

## Requirements

| Requirement           | Value                                      |
|----------------------|---------------------------------------------|
| VPC Name             | `datacenter-pub-vpc`                        |
| Subnet Name          | `datacenter-pub-subnet`                     |
| Subnet               | Must auto-assign public IPs                 |
| EC2 Instance Name    | `datacenter-pub-ec2`                        |
| Instance Type        | `t2.micro`                                  |
| AMI                  | Any Ubuntu AMI                              |
| Networking           | Internet Gateway attached, Route table with internet route |
| Security             | Allow SSH (port 22) from `0.0.0.0/0`        |
| Region               | `us-east-1`                                 |

## Solution (Using AWS CLI)

All commands are executed from the aws-client host.

### Step 1: Set Variables

```bash
REGION="us-east-1"
VPC_NAME="datacenter-pub-vpc"
SUBNET_NAME="datacenter-pub-subnet"
INSTANCE_NAME="datacenter-pub-ec2"
INSTANCE_TYPE="t2.micro"
CIDR_VPC="10.0.0.0/16"
CIDR_SUBNET="10.0.1.0/24"
```

### Step 2: Create the Public VPC

```bash
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $CIDR_VPC \
  --query "Vpc.VpcId" \
  --output text)

aws ec2 create-tags \
  --resources $VPC_ID \
  --tags Key=Name,Value=$VPC_NAME

echo "VPC ID: $VPC_ID"
```

### Step 3: Create and Attach Internet Gateway

```bash
IGW_ID=$(aws ec2 create-internet-gateway \
  --query "InternetGateway.InternetGatewayId" \
  --output text)

aws ec2 attach-internet-gateway \
  --internet-gateway-id $IGW_ID \
  --vpc-id $VPC_ID

echo "Internet Gateway ID: $IGW_ID"
```

### Step 4: Create Public Subnet

```bash
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $CIDR_SUBNET \
  --query "Subnet.SubnetId" \
  --output text)

aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags Key=Name,Value=$SUBNET_NAME

echo "Subnet ID: $SUBNET_ID"
```

### Step 5: Enable Auto-Assign Public IP on Subnet

```bash
aws ec2 modify-subnet-attribute \
  --subnet-id $SUBNET_ID \
  --map-public-ip-on-launch
```

### Step 6: Create Route Table and Internet Route

```bash
RT_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query "RouteTable.RouteTableId" \
  --output text)

aws ec2 create-route \
  --route-table-id $RT_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID

aws ec2 associate-route-table \
  --route-table-id $RT_ID \
  --subnet-id $SUBNET_ID

echo "Route Table ID: $RT_ID"
```

### Step 7: Create Security Group for SSH Access

```bash
SG_ID=$(aws ec2 create-security-group \
  --group-name datacenter-ssh-sg \
  --description "Allow SSH access" \
  --vpc-id $VPC_ID \
  --query "GroupId" \
  --output text)

aws ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

echo "Security Group ID: $SG_ID"
```

### Step 8: Fetch Latest Ubuntu AMI

```bash
AMI_ID=$(aws ec2 describe-images \
  --region $REGION \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
            "Name=state,Values=available" \
  --query "sort_by(Images, &CreationDate)[-1].ImageId" \
  --output text)

echo "AMI ID: $AMI_ID"
```

### Step 9: Launch EC2 Instance in Public Subnet

```bash
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --subnet-id $SUBNET_ID \
  --security-group-ids $SG_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Instance ID: $INSTANCE_ID"
```

### Step 10: Wait for Instance and Fetch Public IP

```bash
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "Public IP: $PUBLIC_IP"
```

### Step 11: Verfication - Check if the instance is assigned a public IP
```bash
aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```