# Day 18 — Create Read-Only EC2 Access IAM Policy

> If you really look closely, most overnight successes took a long time.
>
> — Steve Jobs

## Task Description

When establishing infrastructure on AWS, Identity and Access Management (IAM) is one of the first and most critical services to configure. IAM lets you create and manage users, groups, roles, and policies.

The Nautilus DevOps team needs to configure IAM resources with the following requirement:

## Task Requirement

Create an IAM policy named `iampolicy_kareem` in the `us-east-1` region that grants read-only access to the EC2 console.

This policy must allow users to view:

- All EC2 instances
- AMIs
- Snapshots

It must not allow launching, modifying, or deleting resources.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- All resources must be created only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Create IAM Policy (AWS Console)

### Step 1 — Log in to the AWS Console

1. Use the AWS-provided console URL, username, and password from the lab interface.
2. Ensure the region is set to `us-east-1`.

### Step 2 — Navigate to IAM

1. From the AWS Console home page, search for IAM.
2. Open the IAM Dashboard.

### Step 3 — Create the IAM Policy

1. In the IAM console, select Policies from the left navigation.
2. Click Create policy.
3. Choose the JSON tab.
4. Replace the default JSON with the following:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
```

**Explanation:**

| Element | Description |
|---|---|
| `ec2:Describe*` | Allows all EC2 read-only actions |
| `Resource: "*"` | Read access to all resources (instances, AMIs, snapshots) |

### Step 4 — Name and Tag the Policy

1. Click Next.
2. Set the policy name to: `iampolicy_kareem`
3. (Optional) Add tags such as:
   - `Project=DevOps`
   - `Environment=Training`
4. Click Create policy.

### Step 5 — Verify the Policy

After creation:

1. Search for `iampolicy_kareem` in the Policies list.
2. Open the policy and inspect:
   - Policy summary
   - Allowed actions (`Describe*`)
   - EC2 read-only permissions

## Optional CLI Verification
<Details>
To verify the IAM policy was created using the AWS CLI, run:

```bash
aws iam get-policy --policy-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/iampolicy_kareem
```

To view the policy document:

```bash
aws iam get-policy-version \
  --policy-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/iampolicy_kareem \
  --version-id v1
```

The output should show the policy with `ec2:Describe*` actions.

## Validation (KodeCloud Lab)

To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- IAM policy named `iampolicy_kareem` exists.
- Policy grants read-only access to EC2 (`ec2:Describe*`).
- Policy does not allow write, modify, or delete actions.
- Policy is in the correct account.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 18 completed: you have successfully created the IAM policy `iampolicy_kareem` with read-only EC2 console access. This policy can now be attached to users, groups, or roles to grant them view-only permissions for EC2 resources.

