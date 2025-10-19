Day 97: Create IAM Policy Using Terraform

>It always seems impossible until it's done.

>Success is not final, failure is not fatal: it is the courage to continue that counts.
>
>– Winston Churchill

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements.

Create an `IAM policy` named `iampolicy_siva` in `us-east-1` region using Terraform. It must allow `read-only` access to the EC2 console, i.e., this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different .tf file) to accomplish this task.

`Note:` Right-click under the `EXPLORER` section in VS Code and select `Open in Integrated Terminal` to launch the terminal.

## Solution
```bash
cd /home/bob/terraform
touch main.tf

terraform init

terraform validate

terraform plan

terraform apply -auto-approve
```
