11. Create Alarm Using Terraform

>One day or day one. It's your choice.

The Nautilus DevOps team is setting up monitoring in their AWS account. As part of this, they need to create a CloudWatch alarm.

Using` Terraform`, perform the following:

**Task Details:**

1. Create a CloudWatch alarm named `datacenter-alarm`.
2. The alarm should monitor CPU utilization of an EC2 instance.
3. Trigger the alarm when CPU utilization exceeds 80%.
4. Set the evaluation period to 5 minutes.
5. Use a single evaluation period.

Ensure that the entire configuration is implemented using Terraform. 
- The Terraform working directory is `/home/bob/terraform`. 
- Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` `Right-click` under the `EXPLORER section` in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve
```