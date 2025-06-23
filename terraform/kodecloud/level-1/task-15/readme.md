15. Create IAM Group Using Terraform

>The greatest glory in living, lies not in never falling, but in rising every time we fall.
>
>– Nelson Mandela

>Picture yourself as an indomitable power filled with positive attitude and faith that you are achieving your goals.
>
>– Napolean Hill

>Losers visualize the penalties of failure, Winners visualize the rewards of success.
>
>– Dr.Rob Gilbert


>Question everything. Learn something. Answer nothing.
>
>– Euripides

The mark DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

- Create an `IAM group` named `iamgroup_mark` using terraform.

- The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` `Right-click` under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve

```
**✅ Explanation:**
- `aws_iam_group:` The resource used to create an IAM group.

- `name:` Sets the group name to `iamgroup_mark`.