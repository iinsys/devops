# Day 11 — Attach Elastic Network Interface to EC2 Instance

> You are never too old to set another goal or to dream a new dream.
>
> — Malala Yousafzai

## Task Description

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task:

- An instance named `xfusion-ec2` and an Elastic Network Interface named `xfusion-eni` already exist in the `us-east-1` region.
- Attach the `xfusion-eni` network interface to the `xfusion-ec2` instance.
- Make sure the status is `attached` before submitting the task.
- Please ensure instance initialization has been completed before submitting this task.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-10). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session. You can retrieve credentials by running the `showcreds` command on the aws-client host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Attach ENI Using AWS Console

### Step 1 — Login to AWS Console

1. Use the provided URL and credentials.
2. Make sure the region in the top-right corner is set to: `N. Virginia — us-east-1`

### Step 2 — Verify the EC2 Instance

Navigate to: EC2 Dashboard → Instances → `xfusion-ec2`

Check the following:

- Instance State: `running`
- Status Checks: `2/2 checks passed`

If instance initialization is still running, wait until both checks pass.

### Step 3 — Verify the ENI

Navigate to: EC2 → Network Interfaces

Select `xfusion-eni` and confirm:

- Status: `available`
- Attachment: `none`
- In the correct VPC (usually default)

### Step 4 — Attach ENI to EC2

1. Select `xfusion-eni`.
2. Click Actions.
3. Choose Attach.
4. Select instance: `xfusion-ec2`.
5. Click Attach.

### Step 5 — Validate the Attachment

After attachment, verify on the ENI:

- Status: `in-use`
- Attachment status: `attached`
- Instance ID: matches `xfusion-ec2`

Also verify on the EC2 instance:

1. Go to the Networking tab.
2. You should see:
   - Primary interface: `eth0`
   - Newly attached ENI: `eth1` or similar

## CLI Verification

To verify the ENI attachment using the AWS CLI, run:

```bash
aws ec2 describe-network-interfaces \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=xfusion-eni" \
  --query 'NetworkInterfaces[0].[NetworkInterfaceId,Status,Attachment.InstanceId,Attachment.Status]'
```

This will display the ENI ID, status, attached instance ID, and attachment status.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- The instance `xfusion-ec2` exists and is `running`.
- The ENI `xfusion-eni` exists.
- The ENI is attached to instance `xfusion-ec2`.
- The attachment status is `attached`.
- Instance initialization is complete (status checks: `2/2 passed`).
- Both resources are in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 11 completed: you have successfully attached the Elastic Network Interface `xfusion-eni` to the EC2 instance `xfusion-ec2`, providing it with an additional network interface for enhanced connectivity.

