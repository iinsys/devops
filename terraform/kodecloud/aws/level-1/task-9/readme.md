9. Create EBS Volume Using Terraform

>The secret of success is to do the common things uncommonly well.
>
>– John D. Rockefeller

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

**For this task, create an AWS EBS volume using Terraform with the following requirements:**

- Name of the volume should be `nautilus-volume`.

- Volume type must be `gp3`.

- Volume size must be `2 GiB`.

- The Terraform working directory is `/home/bob/terraform`. 
- Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` `Right-click` under the `EXPLORER` section in `VS Code` and select `Open in Integrated Terminal to launch the terminal`.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve
```
**📝 Notes**
- `availability_zone` is required for EBS volumes; make sure to pick a valid AZ in your configured region.

- This code assumes AWS credentials are configured via environment variables or AWS CLI.