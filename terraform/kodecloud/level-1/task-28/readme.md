28. Enable S3 Versioning Using Terraform


>The way to get started is to quit talking and begin doing.
>
>– Walt Disney

Data protection and recovery are fundamental aspects of data management. It's essential to have systems in place to ensure that data can be recovered in case of accidental deletion or corruption. The DevOps team has received a requirement for implementing such measures for one of the S3 buckets they are managing.

- The S3 bucket name is `devops-s3-26507`, enable `versioning` for this bucket using Terraform.

- The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note`: Right-click under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

**Initial terraform code to be updated**
```tf
resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "devops-s3-26507"
  acl    = "private"

  tags = {
    Name        = "devops-s3-26507"
  }
}
```
The updated code is found in the main.tf in this directory

```bash
terraform init
terraform plan
terraform apply --auto-approve

```

