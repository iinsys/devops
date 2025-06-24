19. Create SNS Topic Using Terraform

>You are exactly where you need to be. You are not behind.

The Nautilus DevOps team needs to set up an SNS topic for sending notifications. They need to create an SNS topic with the following specifications:

1) The topic name should be `devops-notifications`.

Use `Terraform` to create this `SNS topic`. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve
```