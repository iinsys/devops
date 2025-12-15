# Day 19 — Attach IAM Policy to IAM User

> Always bear in mind that your own resolution to success is more important than any other one thing.
>
> – Abraham Lincoln

## Task Description

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

An IAM user named `iamuser_yousuf` and a policy named `iampolicy_yousuf` already exist.  
Attach the IAM policy `iampolicy_yousuf` to the IAM user `iamuser_yousuf`.

**Note:**  
Create the resources only in `us-east-1` region.

## Solution Steps (AWS Console – Wizard Method)

### 1. Log in to the AWS Console

Log in using the AWS-provided credentials (not documented here because they are temporary).

### 2. Navigate to IAM

- From the AWS Console home page, search for **IAM**.
- Open the **IAM Dashboard**.

### 3. Open the IAM User

- In the left navigation panel, click **Users**.
- Search for and select the user `iamuser_yousuf`.

### 4. Attach the Policy to the User

- Inside the user details page, open the **Permissions** tab.
- Click **Add permissions**.
- Choose **Attach policies directly**.
- In the policy search box, type:  
  `iampolicy_yousuf`
- Select the checkbox next to `iampolicy_yousuf`.
- Click **Next**.
- Review the permissions.
- Click **Add permissions**.

### 5. Verify Attachment

- Under the **Permissions** tab of `iamuser_yousuf`, confirm:
  - `iampolicy_yousuf` is listed
  - Policy status shows **Attached**

## Task Completion

The IAM policy `iampolicy_yousuf` has been successfully attached to the IAM user `iamuser_yousuf`, fulfilling all task requirements in the `us-east-1` region.

---

*To retrieve your temporary AWS credentials, use the `showcreds` command on the aws-client host provided by your lab environment.*