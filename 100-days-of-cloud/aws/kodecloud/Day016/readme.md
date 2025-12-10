# Day 16 — Create an IAM User

> Tell me and I forget. Teach me and I remember. Involve me and I learn.
>
> — Benjamin Franklin

## Task Description

The Nautilus DevOps team needs to configure IAM resources. Your task is to create a new IAM user named `iamuser_ammar` in the `us-east-1` region.

## Task Requirements

- Create an IAM user with username: `iamuser_ammar`
- Region: `us-east-1`
- No additional policies or groups are required unless explicitly requested.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Create IAM User (AWS Console)

### Step 1 — Log in to the AWS Console

1. Open the console URL provided by the lab.
2. Enter the username and password.
3. Ensure your region is set to `us-east-1` (check the top-right corner).

### Step 2 — Navigate to IAM

1. In the AWS console search bar, type IAM.
2. Select IAM (Identity and Access Management).

### Step 3 — Create the User

1. In the left sidebar, click Users.
2. Click Create user.
3. Enter the user name: `iamuser_ammar`

Leave remaining settings at default unless otherwise instructed:

- No permissions policies required
- No tags required
- No programmatic access unless asked

Click Create user.

### Step 4 — Verify Creation

Once created, verify that the user appears in the IAM user list:

1. Go to IAM → Users.
2. Search for: `iamuser_ammar`

If it appears in the list, the task is successful.

## Optional CLI Verification

To verify the IAM user was created using the AWS CLI, run:

```bash
aws iam get-user --user-name iamuser_ammar
```

The output should display the user details:

- `UserName: iamuser_ammar`
- `Arn: arn:aws:iam::ACCOUNT_ID:user/iamuser_ammar`
- `CreateDate: <timestamp>`

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- IAM user named `iamuser_ammar` exists.
- User was created successfully.
- User is in the correct account.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 16 completed: you have successfully created the IAM user `iamuser_ammar`. This user can now be configured with additional permissions, access keys, or group memberships as needed for the Nautilus DevOps team's infrastructure.

