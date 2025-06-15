8. Create AMI Using Terraform

> Those who hoard gold have riches for a moment.  
> Those who hoard knowledge and skills have riches for a lifetime.  
>  
> – *The Diary of a CEO*

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

- For this task, create an `AMI` from an existing EC2 instance named `xfusion-ec2` using Terraform.

- Name of the AMI should be `xfusion-ec2-ami`, make sure AMI is in `available state`.

- The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to create the `AMI`.

`Note:` `Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated `Terminal to launch the terminal`.

## Solution
```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```
**📝 Notes**
- `source_instance_id`: References the EC2 instance we just created (`aws_instance.ec2.id`)

- `depends_on`: Ensures the AMI is only created after the instance is successfully launched

- `create_before_destroy`: Helps avoid disruptions if updates are made in the future
