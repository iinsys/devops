21. Cloud Watch Setup Using Terraform

>Success doesn’t come to you, you go to it.
>
>– Marva Collins

The Nautilus DevOps team needs to set up CloudWatch logging for their application. They need to create a CloudWatch log group and log stream with the following specifications:

1) The log group name should be `datacenter-log-group`.

2) The log stream name should be `datacenter-log-stream`.

Use `Terraform` to create the CloudWatch log group and log stream. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init
terraform plan
terraform apply --auto-approve
```