# Day 15 — Create a Snapshot from an Existing EBS Volume

> Those who hoard gold have riches for a moment.
> Those who hoard knowledge and skills have riches for a lifetime.
>
> — The Diary of a CEO

## Task Description

The Nautilus DevOps team has some volumes in different regions in their AWS account. They are going to set up some automated backups so that all important data can be backed up on a regular basis. For now, they have shared some requirements to take a snapshot of one of the volumes they have.

For this task:

- Create a snapshot of an existing volume named `nautilus-vol` in the `us-east-1` region.
- The name of the snapshot must be `nautilus-vol-ss`.
- The description must be `nautilus Snapshot`.
- Ensure the snapshot status is `completed` before submitting the task.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab. Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session.

To retrieve credentials, run the `showcreds` command on the `aws-client` host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Create EBS Snapshot (AWS Console)

### Step 1 — Sign in to the AWS Console

1. Use the provided console URL, username, and password.
2. Make sure the region is set to N. Virginia (`us-east-1`).

### Step 2 — Go to the EC2 Service

1. Click the left sidebar.
2. Select EC2.

### Step 3 — Locate the Volume

In the EC2 menu, scroll down to Elastic Block Store.

Click Volumes.

In the search bar or volume list, locate and confirm:
- Volume Name: `nautilus-vol`
- Volume Status: `available` or `in-use`

### Step 4 — Create a Snapshot

1. Select the volume named `nautilus-vol`.
2. At the top, click Actions → Create snapshot.
3. Fill in the required fields:

| Field | Value |
|---|---|
| Name | `nautilus-vol-ss` |
| Description | `nautilus Snapshot` |

Ensure the correct volume is shown in the form.

Click Create snapshot.

`Note`: if you don't see the field to input the name then after it is created you can edit the snapshot and add the name `nautilus-vol-ss`

### Step 5 — Wait for Snapshot to Complete

1. Go to the left sidebar.
2. Click Snapshots.
3. Locate the snapshot with name `nautilus-vol-ss`.
4. Monitor the status as it transitions:
   - `Pending` (initial state)
   - `Completed` (final state)

Wait until the status shows: `Completed`

This can take several minutes depending on the volume size.

### Step 6 — Task Completion Verification

Verify the following before submitting:

| Requirement | Expected Value |
|---|---|
| Snapshot exists | Yes |
| Snapshot name | `nautilus-vol-ss` |
| Snapshot description | `nautilus Snapshot` |
| Snapshot status | `Completed` |

After confirming all of the above, you can submit the task.

## Optional CLI Verification

To verify the snapshot using the AWS CLI, run:

```bash
aws ec2 describe-snapshots \
  --region us-east-1 \
  --owner-ids self \
  --filters "Name=tag:Name,Values=nautilus-vol-ss" \
  --query 'Snapshots[0].[SnapshotId,State,Description,StartTime]'
```

The output should show:

- `State: completed`
- `Description: nautilus Snapshot`

To monitor snapshot progress, use:

```bash
aws ec2 describe-snapshots \
  --region us-east-1 \
  --owner-ids self \
  --filters "Name=description,Values=nautilus Snapshot" \
  --query 'Snapshots[0].[SnapshotId,State,Progress]'
```

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- Snapshot named `nautilus-vol-ss` exists.
- Snapshot description is `nautilus Snapshot`.
- Snapshot status is `completed`.
- Snapshot was created from volume `nautilus-vol`.
- Snapshot is in `us-east-1` region.

If all requirements are met, the lab will report that the task is completed successfully.

## Completion

Day 15 completed: you have successfully created a snapshot named `nautilus-vol-ss` from the EBS volume `nautilus-vol`. This snapshot can now be used for backup, recovery, or creating additional volumes.

