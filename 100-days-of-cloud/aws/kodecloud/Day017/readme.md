# Day 17 — Create an IAM Group

> If you really look closely, most overnight successes took a long time.
>
> — Steve Jobs

## Task Description

The Nautilus DevOps team continues configuring IAM resources as part of their AWS migration. Your task today is to create an IAM group that will be used to organize users and manage permissions efficiently.

## Task Requirement

- Create an IAM group with name: `iamgroup_anita`
- Region: `us-east-1`
- No policies or users need to be attached unless specifically requested.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Create IAM Group (AWS Console)

### Step 1 — Log in to AWS Console

1. Open the console URL provided by the lab.
2. Enter the username and password.
3. Confirm the region is `us-east-1` (important!).

### Step 2 — Navigate to IAM

1. In the AWS console search bar, type IAM.
2. Select IAM (Identity and Access Management).

### Step 3 — Create the IAM Group

1. In the left navigation pane, click User groups.
2. Click Create group.
3. Enter the group name: `iamgroup_anita`

Do not attach any policies (unless required — here, it is not).

Scroll down and click Create group.

### Step 4 — Verify the Group

1. Go to IAM → User groups.
2. Confirm that the group `iamgroup_anita` appears in the list.

If it shows up, the task is complete.

## Optional CLI Verification

To verify the IAM group was created using the AWS CLI, run:

```bash
aws iam get-group --group-name iamgroup_anita
```

The output should display the group details:

- `GroupName: iamgroup_anita`
- `Arn: arn:aws:iam::ACCOUNT_ID:group/iamgroup_anita`
- `CreateDate: <timestamp>`

To list all groups, use:

```bash
aws iam list-groups --query 'Groups[?GroupName==`iamgroup_anita`]'
```

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- IAM group named `iamgroup_anita` exists.
- Group was created successfully.
- Group is in the correct account.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 17 completed: you have successfully created the IAM group `iamgroup_anita`. This group can now be used to manage permissions for multiple users in the Nautilus DevOps infrastructure.

