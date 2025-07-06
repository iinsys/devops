38. User Variable Setup Using Terraform

>To master a new technology, you will have to play with it.
>
>– Jordan Peterson

The Nautilus DevOps team is automating IAM user creation using Terraform for better identity management.

For this task, create an AWS IAM User using Terraform with the following requirements:

The `IAM User` name `iamuser_rose` should be stored in a variable named `KKE_user`.
`Note:`

1. The configuration values should be stored in a variables.tf file.

2. The Terraform script should be structured with a `main.tf` file referencing `variables.tf`.
- The Terraform working directory is `/home/bob/terraform`.

`Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated Terminal to launch the terminal.

## Solution
**What is an IAM User in AWS?**
An `IAM User` in AWS is an identity created for an individual person or application to interact with AWS resources. Each IAM user has unique credentials and permissions, allowing for secure and controlled access management.

```bash
terraform init

terraform plan

terraform apply --auto-approve
```