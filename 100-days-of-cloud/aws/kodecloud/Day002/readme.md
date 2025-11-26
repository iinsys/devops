# Day 2 — Create Security Group (AWS)

> Tell me and I forget. Teach me and I remember. Involve me and I learn.
>
> — Benjamin Franklin

## Task Description

The Nautilus DevOps team is continuing their phased migration to AWS. As part of the foundational network setup, the team needs a security group that will be used by the application servers during the migration process.

For Day 2, the task is to create a security group with specific inbound rules inside the default VPC.

## Requirements

- Security Group Name: `xfusion-sg`
- Description: Security group for Nautilus App Servers
- VPC: Default VPC
- Inbound Rules:
    - HTTP — Port 80, Source: `0.0.0.0/0`
    - SSH — Port 22, Source: `0.0.0.0/0`
- Region: `us-east-1`

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Day 1). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

## Solution: Create the Security Group (AWS Console)

### Step 1 — Log in to AWS

Use the console URL and the temporary credentials provided by the KodeCloud lab to sign in.

### Step 2 — Navigate to Security Groups

From the AWS Console: EC2 Dashboard → Network & Security → Security Groups

### Step 3 — Create a New Security Group

Click Create security group and enter the following details:

| Setting | Value |
|---|---|
| Security group name | `xfusion-sg` |
| Description | Security group for Nautilus App Servers |
| VPC | Default VPC (auto-selected) |

### Step 4 — Add Inbound Rules

- Rule 1 — HTTP
    - Type: HTTP
    - Protocol: TCP
    - Port range: 80
    - Source: `0.0.0.0/0`

- Rule 2 — SSH
    - Type: SSH
    - Protocol: TCP
    - Port range: 22
    - Source: `0.0.0.0/0`

Click Create security group.

## CLI Verification

To verify the security group using the AWS CLI, run:

```bash
aws ec2 describe-security-groups \
    --region us-east-1 \
    --group-names xfusion-sg
```

The command will return details of the security group, including inbound rules.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The automated script will verify:

- The security group exists.
- The security group is named `xfusion-sg`.
- The description matches.
- The security group is created under the default VPC.
- Both inbound rules (HTTP and SSH) are present.
- All resources are in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 2 completed: the required security group `xfusion-sg` has been created in the correct region with the required inbound rules.
</Details>

#### or if you prefer a video you can watch [Video link](https://www.youtube.com/shorts/k93sw3AYMrY)