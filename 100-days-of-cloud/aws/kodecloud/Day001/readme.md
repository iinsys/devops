# Day 1 — Create Key Pair (AWS)

## Task Description

The Nautilus DevOps team is preparing to migrate parts of their infrastructure to the AWS cloud. As part of the initial setup, they are breaking down large migration tasks into smaller, manageable units to ensure a smooth and controlled transition.

For Day 1, the task is to create an AWS EC2 Key Pair that will be used for securely accessing EC2 instances during later stages of the migration.

## Requirements

- Key Pair Name: `datacenter-kp`
- Key Pair Type: RSA
- Region: `us-east-1`
- Environment: KodeCloud AWS Lab environment

## AWS Credentials (Lab Environment)

Credentials are provided by the KodeCloud lab and are valid only for the session.

- Console URL: Provided by the lab
- Username: Provided by the lab
- Password: Provided by the lab
- Session Duration: 1 hour
- Region: `us-east-1`

## Solution: Create the Key Pair (AWS Console)

### Step 1 — Log in to AWS

Use the lab-provided console link and credentials to log in.

### Step 2 — Navigate to Key Pairs

From the AWS Console: EC2 Dashboard → Network & Security → Key Pairs

### Step 3 — Create the Key Pair

Click Create key pair, then fill in the details:

| Setting | Value |
|---|---|
| Name | `datacenter-kp` |
| Key pair type | RSA |
| Private key file format | `.pem` (recommended) |
| Region | `us-east-1` |

Click Create key pair. A file named `datacenter-kp.pem` will download automatically.

## Validation (KodeCloud Lab)
<Details>
To confirm the task:

1. Return to the KodeCloud lab interface.
2. Click the Check or Validate button.

The automated script verifies:

- The key exists.
- The key is named `datacenter-kp`.
- The key is RSA type.
- The key was created in `us-east-1`.

If everything is correct, the lab will show that the task completed successfully.

## Optional: CLI Verification

Run the following command in the AWS client terminal to verify the key pair:

```bash
aws ec2 describe-key-pairs --region us-east-1 --key-names datacenter-kp
```

If successful, the key pair details will be displayed.

## Completion

Day 1 completed.
</Details>
  
### Or if you prefer a video use [Link](https://www.youtube.com/shorts/CaAnXUBcBcY)
