24. Secrets Manager Setup Using Terraform

>The way to get started is to quit talking and begin doing.
>
>– Walt Disney

The Nautilus DevOps team needs to store sensitive data securely using AWS Secrets Manager. They need to create a secret with the following specifications:

1) The secret name should be `datacenter-secret`.

2) The secret value should contain a `key-value pair` with username: `admin` and password: `Namin123`.

3) Use Terraform to create the secret in `AWS Secrets Manager`.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the `EXPLORER` section in VS Code and select Open in `Integrated Terminal to launch the terminal`.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve
```