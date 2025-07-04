34. Copy Data to S3 Using Terraform

>The most important thing to do in solving a problem is to begin.
>
>– Frank Tyger

The Nautilus DevOps team is presently immersed in data migrations, transferring data from on-premise storage systems to AWS S3 buckets. They have recently received some data that they intend to copy to one of the S3 buckets.

S3 bucket named `devops-cp-25882` already exists. Copy the file `/tmp/devops.txt` to s3 bucket `devops-cp-25882` using Terraform. The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to accomplish this task.

`Note:` `Right-click` under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

```bash
terraform init

terraform plan

terraform apply --auto-approve

```

