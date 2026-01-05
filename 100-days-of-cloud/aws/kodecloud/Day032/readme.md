# Day 32 – Snapshot and Restoration of an RDS Instance

> There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
>
> – Lemony Snicket

## Task Description

The Nautilus Development Team is preparing for a major update to their database infrastructure. To ensure a smooth transition and to safeguard data, the team has requested the DevOps team to take a snapshot of the current RDS instance and restore it to a new instance. This process is crucial for testing and validation purposes before the update is rolled out to the production environment. The snapshot will serve as a backup, and the new instance will be used to verify that the backup process works correctly and that the application can function seamlessly with the restored data.

As a member of the Nautilus DevOps Team, your task is to perform the following:

- **Take a Snapshot:** Take a snapshot of the `datacenter-rds` RDS instance and name it `datacenter-snapshot`. Wait for the `datacenter-rds` instance to be in the available state before taking the snapshot.
- **Restore the Snapshot:** Restore the snapshot to a new RDS instance named `datacenter-snapshot-restore`.
- **Configure the New RDS Instance:** Ensure that the new RDS instance has an instance class of `db.t3.micro`.
- **Verify the New RDS Instance:** The new RDS instance must be in the Available state upon completion of the restoration process.

## Requirements

| Requirement              | Value                          |
|-------------------------|--------------------------------|
| Original RDS Instance   | `datacenter-rds`               |
| Snapshot Name           | `datacenter-snapshot`          |
| Restored RDS Instance   | `datacenter-snapshot-restore`  |
| Instance Class          | `db.t3.micro`                  |
| Region                  | `us-east-1`                    |

## Solution (Using AWS CLI)

### Step 1: Set Variables

```bash
REGION="us-east-1"
DB_INSTANCE="datacenter-rds"
SNAPSHOT_NAME="datacenter-snapshot"
RESTORE_RDS="datacenter-snapshot-restore"
DB_INSTANCE_CLASS="db.t3.micro"
```

### Step 2: Wait for Original RDS to be Available

```bash
aws rds wait db-instance-available \
  --db-instance-identifier $DB_INSTANCE \
  --region $REGION

echo "$DB_INSTANCE is now available."
```

### Step 3: Take a Snapshot of the Original RDS

```bash
aws rds create-db-snapshot \
  --db-instance-identifier $DB_INSTANCE \
  --db-snapshot-identifier $SNAPSHOT_NAME \
  --region $REGION

echo "Snapshot $SNAPSHOT_NAME is being created..."
```

### Step 4: Wait for Snapshot to Complete

```bash
aws rds wait db-snapshot-available \
  --db-snapshot-identifier $SNAPSHOT_NAME \
  --region $REGION

echo "Snapshot $SNAPSHOT_NAME is now available."
```

### Step 5: Restore Snapshot to a New RDS Instance

```bash
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier $RESTORE_RDS \
  --db-snapshot-identifier $SNAPSHOT_NAME \
  --db-instance-class $DB_INSTANCE_CLASS \
  --no-publicly-accessible \
  --region $REGION

echo "Restoring snapshot to $RESTORE_RDS..."
```

Tip: Sometimes the instance takes 30–60 seconds to register. If needed, you can add a short `sleep 30` before waiting.

### Step 6: Wait Until the Restored RDS is Available

```bash
echo "Waiting for $RESTORE_RDS to become available..."
sleep 30  # optional, ensures AWS has registered the instance
aws rds wait db-instance-available \
  --db-instance-identifier $RESTORE_RDS \
  --region $REGION

echo "$RESTORE_RDS is now available."
```

### Step 7: Verify the Restored RDS Instance

```bash
aws rds describe-db-instances \
  --db-instance-identifier $RESTORE_RDS \
  --query "DBInstances[0].[DBInstanceStatus,DBInstanceClass,Engine,PubliclyAccessible]" \
  --output table
```

### Expected Output

| DBInstanceStatus | DBInstanceClass | Engine | PubliclyAccessible |
|------------------|-----------------|--------|-------------------|
| available        | db.t3.micro     | mysql  | False             |

## Task Completed

- Snapshot `datacenter-snapshot` created from `datacenter-rds`
- New RDS instance `datacenter-snapshot-restore` restored from snapshot
- Instance class set to `db.t3.micro`
- Restored instance is available and not publicly accessible

