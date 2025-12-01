# Day 6 — Create EC2 Instance Using AWS Wizard

> Do the best you can. No one can do more than that.
>
> — John Wooden

## Task Description

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

For this task, create an EC2 instance with the following requirements:

- The name of the instance must be `datacenter-ec2`.
- You can use the Amazon Linux AMI to launch this instance.
- The Instance type must be `t2.micro`.
- Create a new RSA key pair named `datacenter-kp`.
- Attach the default (available by default) security group.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-5). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

## Solution: Create EC2 Instance Using AWS Console Wizard

### Step 1 — Navigate to Launch Instance

1. Log in using the provided AWS Console URL, username, and password.
2. On the AWS Management Console home page, open EC2.
3. On the left menu, click Instances.
4. Click Launch instances.

### Step 2 — Configure the EC2 Instance

Inside the Launch an instance wizard:

1. Name your instance
   - At the top, set: `Name = datacenter-ec2`
   - This attaches the Name tag automatically.

### Step 3 — Select AMI

Under Application and OS Images (Amazon Machine Image):

- Choose Amazon Linux (Amazon Linux 2 AMI — this is the one available for labs).

### Step 4 — Select Instance Type

Under Instance Type:

- Select `t2.micro`
- (Free tier eligible and included in all labs.)

### Step 5 — Create RSA Key Pair

1. Find the Key pair (login) section.
2. Click Create new key pair.
3. Configure:

| Setting | Value |
|---|---|
| Name | `datacenter-kp` |
| Key pair type | RSA |
| Private key format | `.pem` (default) |

Click Create key pair. The key file will automatically download.

### Step 6 — Configure Network Settings

Under Network settings:

- Leave VPC and Subnet as default.
- For Security groups: Select Default security group (this is the one available by default and satisfies the requirements).

### Step 7 — Launch the EC2 Instance

1. Scroll down and click Launch instance.
2. You should see a confirmation screen with:
   - Instance ID (e.g., `i-0ab1234cd56789ef0`)
   - Status: Running or Pending

### Step 8 — Verify

Return to Instances list and confirm:

- Instance Name: `datacenter-ec2`
- AMI: Amazon Linux
- Instance Type: `t2.micro`
- Key pair name: `datacenter-kp`
- Security group: default
- Region: `us-east-1`

## CLI Verification

To verify the EC2 instance using the AWS CLI, run:

```bash
aws ec2 describe-instances \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=datacenter-ec2" \
  --query 'Reservations[0].Instances[0].[InstanceId,InstanceType,ImageId,KeyName,SecurityGroups[0].GroupName]'
```

This will display the instance ID, type, AMI, key pair name, and security group.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- An EC2 instance named `datacenter-ec2` exists.
- The instance type is `t2.micro`.
- The AMI is Amazon Linux.
- The key pair is named `datacenter-kp`.
- The security group is the default security group.
- The instance is in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 6 completed: you have successfully created an EC2 instance named `datacenter-ec2` with the required configuration, ready for the next phases of the AWS migration.



