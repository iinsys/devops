# Day 20 — Create IAM Role and Attach Existing Policy

## Task Description

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements:

Create an IAM role as below:

- IAM role name must be `iamrole_kareem`.
- Entity type must be AWS Service and use case must be EC2.
- Attach a policy named `iampolicy_kareem`.

**Notes:**
- Create the resources only in `us-east-1` region.

## Solution (AWS Console – Wizard Method)

### Step 1: Log in to AWS Console

Log in to the AWS Console using the provided credentials and ensure the region is set to `us-east-1`.

### Step 2: Open IAM Service

From the AWS Console search bar, type **IAM**.

Open the IAM service.

### Step 3: Start Creating the IAM Role

In the left navigation menu, click **Roles**.

Click **Create role**.

### Step 4: Select Trusted Entity

Under **Trusted entity type**, select **AWS service**.

Under **Use case**, select **EC2**.

Click **Next**.

### Step 5: Attach Permissions Policy

In the permissions list, search for:

`iampolicy_kareem`

Select the checkbox next to `iampolicy_kareem`.

Click **Next**.

**Important:**  
Do NOT edit or modify the policy.  
The task only requires attaching the existing policy.

### Step 6: Configure Role Name

Enter the role name:

`iamrole_kareem`

(Optional) Leave description empty.

Click **Create role**.

### Step 7: Verify the Role

Go to **IAM → Roles**.

Search for `iamrole_kareem`.

Confirm:

- Trusted entity: `ec2.amazonaws.com`
- Attached policy: `iampolicy_kareem`

## Task Completed Successfully

The IAM role `iamrole_kareem` has been successfully created with:

- AWS Service: EC2
- Existing policy `iampolicy_kareem` attached
- All requirements met in `us-east-1`