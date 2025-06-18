12. Create Public S3 Bucket Using Terraform
>One big reason for a winning attitude 
>is that you will take the necessary steps 
>and not quit when the going gets difficult.
>
>– Don M.Green

As part of the data migration process, the Nautilus DevOps team is actively creating several S3 buckets on AWS. They plan to utilize both private and public S3 buckets to store the relevant data. Given the ongoing migration of other infrastructure to AWS, it is logical to consolidate data storage within the AWS environment as well.

`. Create a `public` **S3 bucket** named `datacenter-s3-32544` using Terraform.

2. `Ensure the bucket is accessible publicly once created by setting the proper ACL`.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

**Notes:**

- Create the resources only in the `us-east-1` region.
- Right-click under the `EXPLORER section` in VS Code and select Open in Integrated Terminal to launch the terminal.
- The name of the S3 bucket should be based on `datacenter-s3-32544`.
- You can use the `ACL` settings to ensure the bucket is publicly accessible.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve

```