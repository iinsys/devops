# Day 7 — Modify EC2 Instance Type Using AWS Console

> Keep your face always toward the sunshine, and shadows will fall behind you.
>
> — Walt Whitman

## Task Description

During the migration process, the Nautilus DevOps team created several EC2 instances in different regions. They are currently in the process of identifying the correct resources and utilization and are making continuous changes to ensure optimal resource utilization. Recently, they discovered that one of the EC2 instances was underutilized, prompting them to decide to change the instance type.

For this task:

- Change the instance type from `t2.micro` to `t2.nano` for the `xfusion-ec2` instance.
- Make sure the EC2 instance `xfusion-ec2` is in running state after the change.
- Please make sure the Status check is completed (if it is still in Initializing state) before making any changes to the instance.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-6). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

## Solution: Modify EC2 Instance Type Using AWS Console

### Step 1 — Log in to AWS

1. Open the provided AWS Console URL.
2. Log in using the given username and password.
3. Ensure the region is `us-east-1` (top-right corner).

### Step 2 — Go to EC2 Dashboard

1. In the AWS search bar, type EC2.
2. Click EC2.
3. On the left sidebar, click Instances.

### Step 3 — Locate the Instance

In the list of instances, find the instance with:
- Name: `xfusion-ec2`

Select the instance.

### Step 4 — Wait for Status Checks to Complete

Before making any changes, ensure:

- Status Check: `2/2 checks passed`

If it shows Initializing, wait until the status becomes `2/2 checks passed`.

### Step 5 — Stop the Instance

Changing instance type requires the instance to be stopped.

1. Select the instance.
2. Click Instance state → Stop instance.
3. Confirm.
4. Wait until the instance state becomes: `Stopped`

### Step 6 — Change the Instance Type

With the instance still selected:

1. Click Actions.
2. Click Instance settings.
3. Click Change instance type.
4. In the Instance type dropdown: Select `t2.nano`.
5. Click Apply (or Save depending on UI version).

### Step 7 — Start the Instance

1. In the Instance state menu, click Start instance.
2. Wait until the instance is `Running`.
3. Wait until: Status Check = `2/2 checks passed`

This confirms the instance is healthy.

### Step 8 — Verify

Confirm the following:

- Instance Name: `xfusion-ec2`
- Instance Type: `t2.nano`
- State: `Running`
- Status checks: `2/2 passed`
- Region: `us-east-1`

## CLI Verification

To verify the EC2 instance type change using the AWS CLI, run:

```bash
aws ec2 describe-instances \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=xfusion-ec2" \
  --query 'Reservations[0].Instances[0].[InstanceId,InstanceType,State.Name]'
```

This will display the instance ID, type (`t2.nano`), and current state.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- The instance `xfusion-ec2` exists.
- The instance type is `t2.nano`.
- The instance state is `Running`.
- Status checks are `2/2 passed`.
- The instance is in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 7 completed: you have successfully modified the EC2 instance `xfusion-ec2` from `t2.micro` to `t2.nano` and verified that it is running with healthy status checks.

