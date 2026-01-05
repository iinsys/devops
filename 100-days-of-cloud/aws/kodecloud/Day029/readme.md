# Day 29 – VPC Peering Between Public and Private VPCs

> I am experienced enough to do this. I am knowledgeable enough to do this. I am prepared enough to do this. I am mature enough to do this. I am brave enough to do this.
>
> – Alexandria Ocasio-Cortez

## Task Description

The Nautilus DevOps team has been tasked with demonstrating the use of VPC Peering to enable communication between two VPCs. One VPC will be a private VPC that contains a private EC2 instance, while the other will be the default public VPC containing a publicly accessible EC2 instance.

### Existing Resources

**Public VPC (Default):**
- EC2 instance: `xfusion-public-ec2`

**Private VPC:**
- VPC Name: `xfusion-private-vpc`
- VPC CIDR: `10.1.0.0/16`
- Subnet Name: `xfusion-private-subnet`
- Subnet CIDR: `10.1.1.0/24`
- EC2 instance: `xfusion-private-ec2`

### Requirements

- Create a Peering Connection between the Default VPC and the Private VPC
  - VPC Peering Connection Name: `xfusion-vpc-peering`
- Configure Route Tables to enable communication between the two VPCs
- Ensure the private EC2 instance is accessible from the public EC2 instance
- Add `/root/.ssh/id_rsa.pub` public key to the public EC2 instance's `ec2-user` authorized_keys
- Update security group of the private EC2 instance to allow ICMP traffic from the public/default VPC CIDR
- SSH into the public EC2 instance and ensure that you can ping the private EC2 instance

## Solution (Using AWS CLI)

### Step 0: Set Region and Variables

```bash
REGION="us-east-1"
```

### Step 1: Get VPC IDs

Default (public) VPC:

```bash
PUBLIC_VPC_ID=$(aws ec2 describe-vpcs \
  --filters "Name=isDefault,Values=true" \
  --query "Vpcs[0].VpcId" \
  --output text)
```

Private VPC:

```bash
PRIVATE_VPC_ID=$(aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=xfusion-private-vpc" \
  --query "Vpcs[0].VpcId" \
  --output text)
```

Verify:

```bash
echo $PUBLIC_VPC_ID
echo $PRIVATE_VPC_ID
```

### Step 2: Create VPC Peering Connection

```bash
PEERING_ID=$(aws ec2 create-vpc-peering-connection \
  --vpc-id $PUBLIC_VPC_ID \
  --peer-vpc-id $PRIVATE_VPC_ID \
  --tag-specifications 'ResourceType=vpc-peering-connection,Tags=[{Key=Name,Value=xfusion-vpc-peering}]' \
  --query "VpcPeeringConnection.VpcPeeringConnectionId" \
  --output text)
```

### Step 3: Accept the Peering Connection

```bash
aws ec2 accept-vpc-peering-connection \
  --vpc-peering-connection-id $PEERING_ID
```

Verify:

```bash
aws ec2 describe-vpc-peering-connections \
  --vpc-peering-connection-ids $PEERING_ID \
  --query "VpcPeeringConnections[0].Status.Code"
```

Expected: `active`

### Step 4: Get Route Tables

Public VPC route table:

```bash
PUBLIC_RT_ID=$(aws ec2 describe-route-tables \
  --filters "Name=vpc-id,Values=$PUBLIC_VPC_ID" "Name=association.main,Values=true" \
  --query "RouteTables[0].RouteTableId" \
  --output text)
```

Private VPC route table:

```bash
PRIVATE_RT_ID=$(aws ec2 describe-route-tables \
  --filters "Name=vpc-id,Values=$PRIVATE_VPC_ID" "Name=association.main,Values=true" \
  --query "RouteTables[0].RouteTableId" \
  --output text)
```

### Step 5: Add Routes for Peering

Public to Private:

```bash
aws ec2 create-route \
  --route-table-id $PUBLIC_RT_ID \
  --destination-cidr-block 10.1.0.0/16 \
  --vpc-peering-connection-id $PEERING_ID
```

Private to Public:

```bash
aws ec2 create-route \
  --route-table-id $PRIVATE_RT_ID \
  --destination-cidr-block 172.31.0.0/16 \
  --vpc-peering-connection-id $PEERING_ID
```

### Step 6: Security Group Updates

**6.1 Public EC2 – Allow SSH from aws-client:**

```bash
PUBLIC_SG_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-public-ec2" \
  --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" \
  --output text)

aws ec2 authorize-security-group-ingress \
  --group-id $PUBLIC_SG_ID \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

Duplicate error is OK if rule already exists.

**6.2 Private EC2 – Allow ICMP from Public VPC:**

```bash
PRIVATE_SG_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-private-ec2" \
  --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" \
  --output text)

aws ec2 authorize-security-group-ingress \
  --group-id $PRIVATE_SG_ID \
  --protocol icmp \
  --port -1 \
  --cidr 172.31.0.0/16
```

### Step 7: Push SSH Key Using Instance Connect

From the aws-client host:

```bash
aws ec2-instance-connect send-ssh-public-key \
  --instance-id $(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=xfusion-public-ec2" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text) \
  --instance-os-user ec2-user \
  --ssh-public-key file:///root/.ssh/id_rsa.pub \
  --region us-east-1
```

### Step 8: Verify Connectivity

SSH into the public EC2 instance and ping the private EC2 instance:

```bash
# Get public EC2 IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-public-ec2" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

# SSH into public instance
ssh ec2-user@$PUBLIC_IP

# From inside, ping private EC2
ping <private-ec2-private-ip>
```


