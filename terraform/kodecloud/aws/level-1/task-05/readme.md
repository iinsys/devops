5 Create VPC with IPv6 Using 
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

For this task, create a VPC named `datacenter-vpc` in the `us-east-1` region with the Amazon-provided IPv6 CIDR block using terraform.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note`: `Right-click` under the `EXPLORER` section in `VS Code` and select `Open in Integrated Terminal` to launch the terminal.

## Solution
```bash
terraform init

terraform plan

terraform apply // type yes to accept the creation of the resource
```
**✅ Explanation**
- `assign_generated_ipv6_cidr_block = true:` Tells AWS to assign an Amazon-provided IPv6 CIDR block.

- `enable_dns_support` and `enable_dns_hostnames:` Enabled for internal resolution and AWS services.

- `tags:` Applies the required name `datacenter-vpc` for identification.

`provider "aws"`: Ensures Terraform runs in the `us-east-1` region.

