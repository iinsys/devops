26. Attach Elastic IP Using Terraform

>Arise, awake, and stop not till the goal is reached.
>– Swami Vivekananda

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

- There is an instance named `nautilus-ec2` and an `elastic-ip` named `nautilus-ec2-eip` in `us-east-1` region.
- Attach the `nautilus-ec2-eip elastic-ip` to the `nautilus-ec2` instance using Terraform only. 
- The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to attach the specified Elastic IP to the instance.

`Note:` `Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
cd /home/bob/terraform

terraform init
terraform plan
terraform apply --auto-approve

```