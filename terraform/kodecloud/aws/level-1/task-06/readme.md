6. Create Elastic IP Using Terraform

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task, allocate an `Elastic IP` address named `nautilus-eip` using `Terraform`.

The Terraform working directory is `/home/bob/terraform`.

Create the `main.tf` file (`do not` create a different `.tf` file) to accomplish this task.

`Note:` `Right-click` under the `EXPLORER` section in `VS Code` and select `Open in Integrated Terminal` to launch the terminal.

```bash
terraform init

terraform plan

terraform apply --auto-approve
```
**🔧 Resource: aws_eip.nautilus_eip**
- Type: `Elastic IP (EIP)`

- Region: `us-east-1`

- Purpose: Allocate a new public IP address for use in your VPC.

- Tags:

  - `Name = nautilus-eip` — this helps identify the EIP in the AWS console.

