# Day 14 — Delete an EC2 Instance

> The greatest glory in living, lies not in never falling, but in rising every time we fall.
>
> — Nelson Mandela

## Task Description

During the migration process, several resources were created under the AWS account. Later on, some of these resources became obsolete as alternative solutions were implemented. Similarly, there is an instance that needs to be deleted as it is no longer in use.

For this task:

- Delete the EC2 instance named `devops-ec2` present in the `us-east-1` region.
- Before submitting your task, ensure the instance is in `terminated` state.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Delete EC2 Instance (AWS Console)

### Step 1 — Sign in to the AWS Console

1. Use the provided console URL, username, and password.
2. Make sure the region in the top-right corner is set to: US East (N. Virginia) — `us-east-1`

### Step 2 — Navigate to EC2

1. Click on the left side menu.
2. Select EC2.
3. The EC2 Dashboard loads.

### Step 3 — Locate the Instance

Navigate to: Instances → Instances

In the search bar or instance list, locate the instance:
- Name: `devops-ec2`

Confirm:
- Instance state: `running` or `stopped`
- Instance ID: any ID is fine as long as the name matches

### Step 4 — Delete (Terminate) the Instance

1. Select the checkbox next to `devops-ec2`.
2. Click Instance state (at the top).
3. Choose Terminate instance.
4. A confirmation window appears.
5. Click Terminate to confirm.

### Step 5 — Wait Until Termination Completes

The instance state will transition:

1. `Shutting-down` (temporary state)
2. `Terminated` (final state)

The instance row will remain visible but greyed out — this is normal.

### Step 6 — Task Completion Check

Verify the final state:

- Instance state: `Terminated`

Only when the instance is in the `Terminated` state, proceed to submit your task.

## Optional CLI Verification

To verify the instance has been terminated, run:

```bash
aws ec2 describe-instances \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=devops-ec2" \
  --query 'Reservations[0].Instances[0].[InstanceId,State.Name]'
```

The output should show:

- State: `terminated`

## Validation (KodeCloud Lab)

<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- The instance `devops-ec2` has been terminated.
- The instance state is `terminated` (not just stopping or pending termination).
- The instance was in the `us-east-1` region.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 14 completed: you have successfully terminated the EC2 instance `devops-ec2`. The instance has been removed from the AWS account and will no longer incur charges.

