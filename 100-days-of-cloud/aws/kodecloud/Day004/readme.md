# Day 4 — Allocate Elastic IP (AWS)

> You are never too old to set another goal or to dream a new dream.
>
> — Malala Yousafzai

## Task Description

As the Nautilus DevOps team continues their planned migration to AWS, the next step is preparing for static and reliable public addressing. Elastic IPs (EIPs) allow AWS resources—such as EC2 instances or NAT gateways—to maintain a consistent public IP address even if the underlying resources are restarted or replaced.

For Day 4, the task is to allocate a new Elastic IP (EIP) and tag it appropriately.

## Requirements

- Elastic IP name (tag): `datacenter-eip`
- Region: `us-east-1`

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-3). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

## Solution: Allocate Elastic IP (AWS Console)

### Step 1 — Open Elastic IP Wizard

Go to EC2 Dashboard → Network & Security → Elastic IPs.

Click Allocate Elastic IP address.

### Step 2 — Configure EIP Settings

- Public IPv4 address pool: Keep the default selection — Amazon's pool of IPv4 addresses.
- The other options (BYOIP, Customer-owned pool, IPv4 IPAM pool) will usually be disabled, which is normal.
- Network border group: Select `us-east-1` (N. Virginia).

This ensures the EIP is in the correct region for this lab.

### Step 3 — Add Tag

1. Scroll down to the Tags section.
2. Click Add Tag.
3. Enter the following:

| Key | Value |
|---|---|
| Name | `datacenter-eip` |

This will ensure the lab validation recognizes the EIP by name.

### Step 4 — Allocate

Click the Allocate button.

The EIP will now be created.

You will see a summary of your new Elastic IP:

- Public IP (example: `3.233.65.229`)
- Allocation ID (example: `eipalloc-xxxxxxxxxxxx`)
- Tag: `Name = datacenter-eip`

### Step 5 — Verify

1. Go back to the Elastic IPs list in the console.
2. Confirm the newly created EIP appears.
3. Ensure the Name column shows `datacenter-eip`.

This is all you need for the task.

## CLI Verification

To verify the Elastic IP using the AWS CLI, run:

```bash
aws ec2 describe-addresses \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=datacenter-eip"
```

You should see the allocated Elastic IP details in the output.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The system will verify:

- An Elastic IP exists.
- The Elastic IP is created in `us-east-1`.
- The Elastic IP has a tag `Name = datacenter-eip`.

If everything matches, the lab will report that the task is completed successfully.
</Details>

## Completion

Day 4 completed: you have successfully allocated an Elastic IP and tagged it as `datacenter-eip`, ready for future use in the migration workflow.

