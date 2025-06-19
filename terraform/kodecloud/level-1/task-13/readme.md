13. Create Private S3 Bucket Using Terraform

>All you need is the plan, the road map, and the courage to press on to your destination.
>
>– Earl Nightingale

As part of the data migration process, the Nautilus DevOps team is actively creating several S3 buckets on AWS using Terraform. They plan to utilize both private and public S3 buckets to store the relevant data. Given the ongoing migration of other infrastructure to AWS, it is logical to consolidate data storage within the AWS environment as well.

Create an S3 bucket using Terraform with the following details:

1) The name of the S3 bucket must be `nautilus-s3-28782`.

2) The S3 bucket must block all `public` access, making it a private bucket.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Notes:`

- Use Terraform to provision the S3 bucket.
- Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.
- Ensure the resources are created in the `us-east-1` region.
- The bucket must have block public access enabled to restrict any public access.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve

```
**✅ Breakdown:**
- `aws_s3_bucket:` Creates the bucket `nautilus-s3-28782` in `us-east-1`.

- `aws_s3_bucket_public_access_block:` Ensures the bucket is completely private.

- `aws_s3_bucket_ownership_controls:` Required to avoid warnings with new S3 defaults.

- `force_destroy = true:` Optional, allows bucket deletion even if it contains objects (handy for testing/cleanup).

