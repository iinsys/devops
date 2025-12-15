# Day 21 — Create EC2 Instance and Associate Elastic IP

> People who are really serious about software should make their own hardware.
>
> – Alan Kay

## Task Description

The Nautilus DevOps Team has received a new request from the Development Team to set up a new EC2 instance. This instance will be used to host a new application that requires a stable IP address. To ensure that the instance has a consistent public IP, an Elastic IP address needs to be associated with it. The instance will be named `devops-ec2`, and the Elastic IP will be named `devops-eip`. This setup will help the Development Team to have a reliable and consistent access point for their application.

Create an EC2 instance named `devops-ec2` using any Linux AMI like Ubuntu. The instance type must be `t2.micro` and associate an Elastic IP address with this instance, naming it as `devops-eip`.

**Notes:**
- Create the resources only in `us-east-1` region.

## Solution (AWS Console – Wizard Method)

### Step 1: Log in to AWS Console

Log in to the AWS Console and ensure the region is set to `us-east-1`.

### Step 2: Launch EC2 Instance

- Navigate to **EC2**
- Click **Instances**
- Click **Launch instance**

### Step 3: Configure EC2 Instance

- **Name:** `devops-ec2`
- **AMI:** Select Ubuntu Linux (or any Linux AMI as allowed)
- **Instance Type:** `t2.micro`
- **Key Pair:** Choose any existing key pair or create a new one if required
- **Network Settings:** Use default VPC, allow default security group settings
- **Storage:** Leave default storage settings

Click **Launch instance**.

### Step 4: Verify Instance Status

- Go to **EC2 → Instances**
- Ensure `devops-ec2` state is **Running**

### Step 5: Allocate Elastic IP

- In EC2 dashboard, click **Elastic IPs**
- Click **Allocate Elastic IP address**
- Keep default settings (Amazon IPv4 pool)
- Click **Allocate**

### Step 6: Tag the Elastic IP

- Select the newly allocated Elastic IP
- Click **Actions → Manage tags**
- Add tag:  
  - **Key:** Name  
  - **Value:** devops-eip
- Save changes

### Step 7: Associate Elastic IP with EC2 Instance

- Select the Elastic IP
- Click **Actions → Associate Elastic IP address**
- **Resource type:** Instance
- **Instance:** devops-ec2
- **Private IP:** Auto-selected
- Click **Associate**

### Step 8: Verification

- Go to **EC2 → Instances**
- Open `devops-ec2`
- Confirm **Public IPv4 address** matches the Elastic IP
- Go to **Elastic IPs**
- Confirm **Elastic IP devops-eip is Associated**

## Task Completed Successfully
<Details>
- EC2 instance `devops-ec2` created
- Instance type: `t2.micro`
- Linux AMI used
- Elastic IP `devops-eip` allocated and associated
- All requirements satisfied in `us-east-1`