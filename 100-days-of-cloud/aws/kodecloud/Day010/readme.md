# Day 10 — Attach an Elastic IP to an EC2 Instance

> Keep your face always toward the sunshine, and shadows will fall behind you.
>
> — Walt Whitman

## Task Description

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task:

- There is an instance named `devops-ec2` and an Elastic IP named `devops-ec2-eip` in the `us-east-1` region.
- Attach the `devops-ec2-eip` Elastic IP to the `devops-ec2` instance.

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab (same approach as Days 1-9). Do not include or store credentials in this repository. Use the lab console URL and temporary credentials provided by the lab interface for the session. You can retrieve credentials by running the `showcreds` command on the aws-client host.

## Important Notes

- Create the resources only in `us-east-1` region.
- To display or hide the terminal of the AWS client machine, use the expand toggle button as shown in the lab interface.

## Solution: Attach Elastic IP Using AWS Console

### Step 1 — Log in to AWS

1. Open the provided AWS Console URL.
2. Enter the provided username and password.
3. Ensure the region at the top right is set to `us-east-1`.

### Step 2 — Identify the EC2 Instance

1. From the AWS Console search bar, type EC2.
2. Open the EC2 Dashboard.
3. On the left panel, click Instances.
4. Locate the instance with Name: `devops-ec2`
5. Select the instance and note its:
   - Instance ID
   - Private IP address (you will need this in the next step)

### Step 3 — Open Elastic IPs Section

In the EC2 Dashboard left sidebar:

1. Click Elastic IPs under Network & Security.
2. Locate the Elastic IP with Name: `devops-ec2-eip`

### Step 4 — Associate the Elastic IP

1. Select the Elastic IP `devops-ec2-eip`.
2. Click the Actions dropdown.
3. Choose Associate Elastic IP address.

A form will appear with multiple fields.

### Step 5 — Configure Association Settings

Set the following:

- Resource type: Instance
- Instance: Select `devops-ec2`
- Private IP address: Select the available private IP of the instance (usually pre-selected)
- Leave all other fields as default.

Click Associate.

### Step 6 — Verify the Association

1. Go back to Elastic IPs.
2. Select `devops-ec2-eip`.
3. Confirm:
   - Associated instance: `devops-ec2`
   - Association ID: Now present (indicates success)

You can also check under: EC2 → Instances → `devops-ec2` → Networking tab

The public IPv4 address should now be the Elastic IP.

## CLI Verification

To verify the Elastic IP attachment using the AWS CLI, run:

```bash
aws ec2 describe-addresses \
  --region us-east-1 \
  --filters "Name=tag:Name,Values=devops-ec2-eip" \
  --query 'Addresses[0].[PublicIp,AssociationId,InstanceId]'
```

This will display the Elastic IP, association ID, and associated instance ID.

## Validation (KodeCloud Lab)
<Details>
To confirm the task in the lab interface:

1. Return to the KodeCloud lab page.
2. Click Check, Validate, or Submit (depending on the lab interface).

The validation engine will verify:

- The instance `devops-ec2` exists.
- The Elastic IP `devops-ec2-eip` exists.
- The Elastic IP is associated with instance `devops-ec2`.
- Both resources are in `us-east-1`.

If everything matches, the lab will report that the task is completed successfully.

## Completion

Day 10 completed: you have successfully attached the Elastic IP `devops-ec2-eip` to the EC2 instance `devops-ec2`, providing it with a static public IP address for the migration workflow.
