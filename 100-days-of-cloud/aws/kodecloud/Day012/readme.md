# Day 12 — Attach Volume to EC2 Instance

> There is no substitute for hard work.
>
> — Thomas Edison

## Task Description

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

An instance named `xfusion-ec2` and a volume named `xfusion-volume` already exist in the `us-east-1` region. Attach the `xfusion-volume` volume to the `xfusion-ec2` instance. Make sure to set the device name to `/dev/sdb` while attaching the volume.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Solution: Attach EBS Volume (AWS Console)

### Step 1 — Log in to AWS

Open the provided AWS Console URL.

Use the temporary credentials from the lab interface.

Verify that the region in the top-right corner is set to:

**N. Virginia (us-east-1)**

### Step 2 — Verify the EC2 Instance

Navigate to:

EC2 Dashboard → Instances

Select the instance named `xfusion-ec2`.

Confirm the following:

| Requirement | Expected Value |
|---|---|
| Instance State | running |
| Status Checks | 2/2 checks passed |
| Region | us-east-1 |

If instance initialization is still in progress, wait until both status checks pass before proceeding.

### Step 3 — Verify the EBS Volume

Navigate to:

EC2 Dashboard → Elastic Block Store → Volumes

Locate the volume named `xfusion-volume`.

Confirm the following:

| Requirement | Expected Value |
|---|---|
| Volume State | available |
| Availability Zone | Must match instance AZ (e.g., us-east-1a) |
| Region | us-east-1 |

Note: EBS volumes can only attach to instances in the same Availability Zone.

### Step 4 — Attach Volume to EC2

Select the volume `xfusion-volume`.

Click **Actions**.

Choose **Attach volume**.

In the attachment form, configure:

| Setting | Value |
|---|---|
| Instance | xfusion-ec2 |
| Device name | /dev/sdb |

Click **Attach**.

### Step 5 — Validate the Attachment

After the volume is attached, verify:

**On the Volume:**

Navigate to Volumes and select `xfusion-volume`.

Confirm:

| Field | Expected Value |
|---|---|
| State | in-use |
| Attachment State | attached |
| Attached Instance | xfusion-ec2 |

**On the EC2 Instance:**

Navigate to Instances and select `xfusion-ec2`.

Go to the **Storage** tab.

You should see:

- Root volume: `/dev/xvda`
- Newly attached volume: `/dev/sdb`

### Step 6 — Final Validation Checklist

Before submitting the task, verify all requirements:

| Requirement | Status |
|---|---|
| Volume `xfusion-volume` attached to instance | Confirmed |
| Device name set to `/dev/sdb` | Confirmed |
| Volume state: `in-use` | Confirmed |
| Instance state: `running` | Confirmed |
| Region: `us-east-1` | Confirmed |
| Status checks: `2/2 passed` | Confirmed |

## Optional CLI Verification

In the AWS client terminal, run:

```bash
aws ec2 describe-volumes \
    --region us-east-1 \
    --filters "Name=tag:Name,Values=xfusion-volume"