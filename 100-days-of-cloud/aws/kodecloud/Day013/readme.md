# Day 13 — Create AMI from EC2 Instance

> There is only one success - to be able to spend your life in your own way.
>
> — Christopher Morley

## Task Description

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task:

- Create an AMI from an existing EC2 instance named `devops-ec2`.
- The name of the AMI should be `devops-ec2-ami`.
- Ensure the AMI is in `available` state before submitting.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Create AMI (AWS Console)

### Step 1 — Log in to AWS Console

1. Use the provided console URL and credentials.
2. Select the region: `us-east-1` (N. Virginia)

### Step 2 — Verify the EC2 Instance

Navigate to: EC2 Dashboard → Instances

Locate the instance named `devops-ec2`.

Verify:

| Requirement | Expected Value |
|---|---|
| Instance State | running |
| Status Checks | 2/2 checks passed |
| Pending Operations | None |

If status checks are still "Initializing", wait until both checks pass. AWS recommends creating AMIs only when the instance is fully initialized.

### Step 3 — Create AMI

1. Select the instance `devops-ec2`.
2. Click Actions → Image and templates → Create image.
3. Fill in the required fields:

| Field | Value |
|---|---|
| Image name | `devops-ec2-ami` |
| Image description | (optional — you can leave blank) |
| No reboot | Leave unchecked (default recommended) |

Click Create image.

A confirmation popup will appear with an AMI ID (e.g., `ami-0abc123def456`).

### Step 4 — Verify AMI Creation

Navigate to: EC2 Dashboard → Images → AMIs

Apply filters:

- Owned by me
- Region: `us-east-1`

Locate the AMI named `devops-ec2-ami`.

Monitor the status:

- Status will progress from `pending` → `available`
- This usually takes 1–3 minutes depending on instance size.

### Step 5 — Final Validation Checklist

Before submitting the task, verify:

| Requirement | Status |
|---|---|
| AMI created from `devops-ec2` | Confirmed |
| AMI name is exactly `devops-ec2-ami` | Confirmed |
| AMI state: `available` | Confirmed |
| Region: `us-east-1` | Confirmed |

Once all checks are correct, submit the task.

## Optional CLI Verification

In the AWS client terminal, run:

```bash
aws ec2 describe-images \
  --region us-east-1 \
  --owners self \
  --filters "Name=name,Values=devops-ec2-ami"
```

You should see the AMI with:

- `State: available`
- `Name: devops-ec2-ami`
- `OwnerId: <your-account-id>`

To monitor AMI creation progress, use:

```bash
aws ec2 describe-images \
  --region us-east-1 \
  --owners self \
  --query 'Images[?Name==`devops-ec2-ami`].[ImageId,State,CreationDate]'
```

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- AMI named `devops-ec2-ami` exists.
- AMI state is `available`.
- AMI is in `us-east-1` region.
- AMI was created from instance `devops-ec2`.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 13 completed: you have successfully created an AMI named `devops-ec2-ami` from the EC2 instance `devops-ec2`. This AMI can now be used to launch new instances with the same configuration.

