39. Role Variable Setup Using Terraform

>All you need is the plan, the road map, and the courage to press on to your destination.
>
>– Earl Nightingale

The Nautilus DevOps team is automating IAM role creation using Terraform to streamline permissions management. As part of this task, they need to create an IAM role with specific requirements.

For this task, create an `AWS IAM role` using `Terraform` with the following requirements:

The `IAM role` name `iamrole_siva` should be stored in a variable named `KKE_iamrole`.
Note:

1. The configuration values should be stored in a `variables.tf` file.

2. The Terraform script should be structured with a `main.tf` file referencing `variables.tf`.
The Terraform working directory is `/home/bob/terraform`.

`Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

**What is an IAM Role in AWS?**
An IAM Role in AWS is an identity with specific permissions that can be assumed by users, applications, or services. Unlike IAM users, roles do not have long-term credentials. Instead, they provide temporary security credentials for trusted entities to perform actions in AWS. IAM roles are commonly used to delegate access and enable secure cross-account or service-to-service interactions.

```bash
terraform init

terraform plan

terraform apply --auto-approve
```