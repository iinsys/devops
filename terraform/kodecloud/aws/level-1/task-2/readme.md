2. Create Security Group Using Terraform

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

Use Terraform to create a security group under the default VPC with the following requirements:

1) The name of the security group must be `nautilus-sg`.

2) The description must be `Security group for Nautilus App Servers`.

3) Add an inbound rule of type `HTTP`, with a port range of `80`, and source CIDR range `0.0.0.0/0`.

4) Add another inbound rule of type `SSH`, with a port range of `22`, and source CIDR range `0.0.0.0/0`.

Ensure that the security group is created in the `us-east-1` region using Terraform. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note`: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init
terraform plan
terraform apply --auto-approve ##to sure
```
 ### ✅ What This Does
- Retrieves the default VPC using a data source.

- Creates a security group called nautilus-sg in that VPC.

- Adds two inbound rules:

  - HTTP (port 80) from 0.0.0.0/0

  - SSH (port 22) from 0.0.0.0/0

- Adds a default outbound rule to allow all traffic.
