37. Elastic IP Variable Setup Using Terraform

> Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. As part of this phased migration approach, they need to allocate an Elastic IP address to support external access for specific workloads.

For this task, create an AWS Elastic IP using Terraform with the following requirement:

- The `Elastic IP` name `devops-eip` should be stored in a variable named `KKE_eip`. 
- The Terraform working directory is `/home/bob/terraform`.
`Note:`

- The configuration values should be stored in a `variables.tf` file.

- The Terraform script should be structured with a `main.tf` file referencing `variables.tf`.

`Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated Terminal to launch the terminal.

## Solution 
**What is an `Elastic IP (EIP)` in AWS?**
An `Elastic IP (EIP)` in AWS is a static, public IPv4 address designed for dynamic cloud computing. It allows you to associate a fixed public IP with your AWS resources (such as EC2 instances), making it easier to maintain a consistent IP address even if you stop and start your instances. EIPs are useful for workloads that require reliable external access.

```bash

terraform init

terraform plan

terraform apply --auto-approve
```