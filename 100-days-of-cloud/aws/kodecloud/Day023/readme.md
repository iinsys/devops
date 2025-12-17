# Day 23 — S3 Bucket Data Migration (AWS CLI)

> Those who hoard gold have riches for a moment.
> Those who hoard knowledge and skills have riches for a lifetime.
>
> – The Diary of a CEO

## Task Description

As part of a data migration project, the team lead has tasked the team with migrating data from an existing S3 bucket to a new S3 bucket. The existing bucket contains a substantial amount of data that must be accurately transferred to the new bucket. The team is responsible for creating the new S3 bucket and ensuring that all data from the existing bucket is copied or synced to the new bucket completely and accurately. It is imperative to perform thorough verification steps to confirm that all data has been successfully transferred to the new bucket without any loss or corruption.

As a member of the Nautilus DevOps Team, your task is to perform the following:

- Create a New Private S3 Bucket: Name the bucket `nautilus-sync-13516`.
- Data Migration: Migrate the entire data from the existing `nautilus-s3-31117` bucket to the new `nautilus-sync-13516` bucket.
- Ensure Data Consistency: Ensure that both buckets have the same data.
- Use AWS CLI: Use the AWS CLI to perform the creation and data migration tasks.

**Notes**

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, you can use the expand toggle button.

## Solution (Using AWS CLI)

### Step 1: Set environment variables

```bash
REGION="us-east-1"
SOURCE_BUCKET="nautilus-s3-31117"
DEST_BUCKET="nautilus-sync-13516"
```

### Step 2: Create the destination S3 bucket

Important: For `us-east-1`, do not specify a location constraint.

```bash
aws s3api create-bucket \
  --bucket "$DEST_BUCKET" \
  --region "$REGION"
```

### Step 3: Verify bucket creation

```bash
aws s3 ls | grep "$DEST_BUCKET"
```

### Step 4: Migrate data from source bucket to destination bucket

```bash
aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET
```

This command:

- Copies all objects
- Preserves directory structure
- Transfers only missing or changed files

### Step 5: Verify data consistency

Option 1: Compare object count

```bash
aws s3 ls s3://$SOURCE_BUCKET --recursive | wc -l
aws s3 ls s3://$DEST_BUCKET --recursive | wc -l
```

Both counts should match.

Option 2: Compare total bucket size

```bash
aws s3 ls s3://$SOURCE_BUCKET --recursive --summarize
aws s3 ls s3://$DEST_BUCKET --recursive --summarize
```

Total size and object count should be identical.

### Step 6: Spot-check files (optional but recommended)

```bash
aws s3 ls s3://$SOURCE_BUCKET/
aws s3 ls s3://$DEST_BUCKET/
```



