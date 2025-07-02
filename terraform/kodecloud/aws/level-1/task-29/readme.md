29. Delete Backup from S3 Using Terraform
>You don’t understand anything until you learn it more than one way.
>
>– Marvin Minsky

The Nautilus DevOps team is currently engaged in a cleanup process, focusing on removing unnecessary data and services from their AWS account. As part of the migration process, several resources were created for one-time use only, necessitating a cleanup effort to optimize their AWS environment.

A S3 bucket named `xfusion-bck-10743` already exists.

1) Copy the contents of `xfusion-bck-10743` S3 bucket to `/opt/s3-backup/` directory on `terraform-client` host (the landing host once you load this lab).

2) Delete the S3 bucket `xfusion-bck-10743`.

3) Use the AWS CLI through Terraform to accomplish this task—for example, by running AWS CLI commands within Terraform. The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to accomplish this task.

`Note:` Right-click under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
📝 **Explanation**
- `null_resource.copy_s3_bucket:` Copies everything from the bucket to /opt/s3-backup/

- `null_resource.delete_s3_bucket:` Deletes contents, then deletes the bucket itself

- `depends_on:` Ensures the backup completes before deletion

```bash
terraform init

terraform apply --auto-approve

```







