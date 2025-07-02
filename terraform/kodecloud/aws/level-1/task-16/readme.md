16. Create IAM Policy Using Terraform

>There is no substitute for hard work.
>
>– Thomas Edison

>You don’t learn to walk by following rules. You learn by doing, and falling over.
>
>– Richard Branson

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements.

- Create an `IAM policy` named `iampolicy_rose` in `us-east-1` region using Terraform. It must allow `read-only` access to the EC2 console, i.e., this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

- The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution 
**🔍 Explanation:**

- `ec2:Describe*` covers permissions like:

- `DescribeInstances`

- `DescribeImages (AMIs)`

- `DescribeSnapshots`

- etc.

- GetConsoleOutput and GetPasswordData are also read-level actions and safe to include.

- This will make the policy named `iampolicy_rose` available in the AWS IAM console under "Policies".


```bash
terraform init

terraform plan

terraform apply --auto-approve

```

