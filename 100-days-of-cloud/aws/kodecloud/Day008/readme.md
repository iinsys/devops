# Day 8 — Enable Stop Protection on an EC2 Instance

> You don't get what you wish for. You get what you work for.
>
> — Daniel Milstein

## Task Description

As part of the migration, there were some components added to the AWS account. The team created one of the EC2 instances where they need to make some changes now.

For this task:

- There is an EC2 instance named `xfusion-ec2` under the `us-east-1` region.
- Enable the stop protection for this instance.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-7). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session. You can retrieve credentials by running the `showcreds` command on the aws-client host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Enable Stop Protection Using AWS Console

### Step 1 — Log in to AWS

1. Open the provided AWS Console URL.
2. Log in using the username and password.
3. Confirm that the region is set to `us-east-1`.

### Step 2 — Go to EC2 Dashboard

1. Search for EC2 in the AWS console search bar.
2. Click to open the EC2 Dashboard.
3. In the left sidebar, select Instances.

### Step 3 — Select the Target Instance

Look for the instance with:
- Name: `xfusion-ec2`

Select the instance from the list.

### Step 4 — Enable Stop Protection

With the instance selected:

1. Click Actions.
2. Choose Instance settings.
3. Click Modify instance protection.

A panel will open showing:
- Stop Protection
- Termination Protection

Locate and check the box for: Enable stop protection

Click Save or Update.

### Step 5 — Verify the Setting

With the instance still selected:

1. Scroll to the Details tab at the bottom.
2. Look for: Stop protection: `Enabled`

If it shows `Enabled`, then the change is successful.

### Step 6 — Final Checks

Ensure the following are all correct:

- Instance Name: `xfusion-ec2`
- Region: `us-east-1`
- Instance State: `Running` (stop protection does not require stopping)
- Stop Protection: `Enabled`

## CLI Verification

To verify stop protection is enabled using the AWS CLI, run:

```bash
aws ec2 describe-instance-attribute \
  --instance-id <instance-id> \
  --region us-east-1 \
  --attribute disableApiStop
```

Replace `<instance-id>` with the actual instance ID of `xfusion-ec2`. The output should show `DisableApiStop: true` indicating stop protection is enabled.

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
- Stop protection is `Enabled`.
- The instance state is `Running`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 8 completed: you have successfully enabled stop protection on the EC2 instance `xfusion-ec2`, preventing accidental termination via the stop command.

