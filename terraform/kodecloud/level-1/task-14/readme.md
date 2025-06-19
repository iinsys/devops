14. Create IAM User Using Terraform

>Do the best you can. No one can do more than that.
>
>– John Wooden

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements:

For this task, create an IAM user named `iamuser_ravi` using `terraform`. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve

```
**✅ What this does:**
- Creates a new IAM user named `iamuser_ravi`

- Adds a simple Name tag for traceability

- Uses `us-east-1` as the AWS region