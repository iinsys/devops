22. Cloud Formation Template Deployment Using Terraform

>You are exactly where you need to be. You are not behind.

The Nautilus DevOps team is working on automating infrastructure deployment using AWS CloudFormation. As part of this effort, they need to create a CloudFormation stack that provisions an S3 bucket with versioning enabled.

- Create a `CloudFormation stack` named `devops-stack` using `Terraform`. 
- This stack should contain an `S3 bucket `named `devops-bucket-6500` as a resource, and the bucket must have `versioning` enabled. 
- The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` `Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash

terraform init

terraform plan

terraform apply --auto-approve

```