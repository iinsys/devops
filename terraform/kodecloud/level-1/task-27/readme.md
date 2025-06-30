27. Attach Policy Using Terraform


>You don't get what you wish for. You get what you work for.
>– Daniel Milstein

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

- An IAM user named `iamuser_anita` and a policy named `iampolicy_anita` already exists. 
- Use Terraform to attach the `IAM policy` `iampolicy_anita` to the IAM user `iamuser_anita`. 
- The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to attach the specified IAM policy to the IAM user.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve
```