# Day 3 — Create Subnet (AWS)

> There is no elevator to success, you have to take the stairs.
>
> — Zig Ziglar

## Task Description

As part of the gradual AWS migration strategy, the Nautilus DevOps team is expanding their network infrastructure in the cloud. For this phase of the migration, the team needs to create a new subnet inside the default Virtual Private Cloud (VPC). Subnets are essential for isolating and organizing resources within AWS networking.

For Day 3, the task is to create a single subnet in the default VPC.

## Requirements

- Subnet Name: `devops-subnet`
- VPC: Default VPC
- Region: `us-east-1`
- Other settings:
  - AWS will pre-fill the default VPC CIDR block.
  - Choose any available IPv4 CIDR within the default VPC range (e.g., `172.31.32.0/20`, or follow the console suggestion).
  - Availability Zone can be any (e.g., `us-east-1a`).

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Day 1). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

## Solution: Create the Subnet (AWS Console)

### Step 1 — Log In

Use the console URL and temporary credentials provided by the KodeCloud lab to sign in.

### Step 2 — Navigate to Subnets

From the AWS Console: VPC Dashboard → Subnets

Click Create subnet.

### Step 3 — Configure Subnet Details

Fill in the required fields:

| Setting | Value |
|---|---|
| VPC ID | Default VPC (auto-selected) |
| Subnet name | `devops-subnet` |
| Availability Zone | Any (e.g., `us-east-1a`, `us-east-1b`, etc.) |
| IPv4 CIDR block | Choose any unused CIDR inside the default VPC |

Example valid CIDR blocks for default VPC (`172.31.0.0/16`):

- `172.31.32.0/20`
- `172.31.48.0/20`
- `172.31.64.0/20`

The console typically suggests an available range — using that suggestion is fine.

`Note:` Select the CIDR block range that won't overlap if you get a warning

### Step 4 — Save

Click Create subnet.

The subnet will now appear in the list under the default VPC.

## CLI Verification

To verify the subnet using the AWS CLI, run:

```bash
aws ec2 describe-subnets \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=devops-subnet"
```

This will return the subnet ID and details.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will check:

- A subnet exists named `devops-subnet`.
- The subnet is inside the default VPC.
- The subnet is created in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.
</Details>

## Completion

Day 3 completed: you have successfully created the required subnet `devops-subnet` in the default VPC. This subnet will be used for future networking-related tasks in the AWS migration sequence.

