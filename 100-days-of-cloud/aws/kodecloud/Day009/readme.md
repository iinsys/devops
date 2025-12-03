# Day 9 — Enable Termination Protection on an EC2 Instance

> Two things define you: your patience when you have nothing and your attitude when you have everything.
>
> — George Bernard Shaw

## Task Description

As part of the migration, there were some components created under the AWS account. The Nautilus DevOps team created one EC2 instance where they forgot to enable the termination protection which is needed for this instance.

For this task:

- An instance named `xfusion-ec2` already exists in the `us-east-1` region.
- Enable termination protection for the same instance.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-8). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session. You can retrieve credentials by running the `showcreds` command on the aws-client host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Enable Termination Protection Using AWS Console

### Step 1 — Log in to AWS

1. Open the provided AWS Console URL.
2. Enter the username and password.
3. Verify that the region is set to `us-east-1`.

### Step 2 — Navigate to EC2 Dashboard

1. In the AWS search bar, type EC2.
2. Open the EC2 Dashboard.
3. On the left menu, select Instances.

### Step 3 — Locate the Instance

Look for the EC2 instance with:
- Name: `xfusion-ec2`

Select the instance by checking the checkbox next to it.

### Step 4 — Enable Termination Protection

With the instance selected:

1. Click Actions.
2. Select Instance settings.
3. Choose Modify termination protection.

A configuration panel will appear.

Enable: Termination Protection

Click Save or Update.

### Step 5 — Verify the Change

While still viewing the instance:

1. Open the Details tab.
2. Scroll to find the field: Termination protection: `Enabled`

If it shows `Enabled`, the task is complete.

### Step 6 — Final Validation

Ensure all of the following are correct:

- Instance Name: `xfusion-ec2`
- Region: `us-east-1`
- Instance Status: `Running` (termination protection does not require stopping)
- Termination Protection: `Enabled`

## CLI Verification

To verify termination protection is enabled using the AWS CLI, run:

```bash
aws ec2 describe-instance-attribute \
  --instance-id <instance-id> \
  --region us-east-1 \
  --attribute disableApiTermination
```

Replace `<instance-id>` with the actual instance ID of `xfusion-ec2`. The output should show `DisableApiTermination: true` indicating termination protection is enabled.

Alternatively, find the instance ID with:

```bash
aws ec2 describe-instances \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=xfusion-ec2" \
  --query 'Reservations[0].Instances[0].InstanceId' \
  --output text
```

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- The instance `xfusion-ec2` exists.
- The instance is in `us-east-1`.
- Termination protection is `Enabled`.
- The instance state is `Running`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 9 completed: you have successfully enabled termination protection on the EC2 instance `xfusion-ec2`, preventing accidental deletion of this critical instance.

