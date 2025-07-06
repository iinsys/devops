36. Security Group Variable Setup Using Terraform

>Losers visualize the penalties of failure, Winners visualize the rewards of success.
>
>– Dr.Rob Gilbert

The Nautilus DevOps team is enhancing infrastructure automation and needs to provision a Security Group using Terraform with specific configurations.

For this task, create an AWS Security Group using Terraform with the following requirements:

The Security Group name `nautilus-sg` should be stored in a variable named `KKE_sg`.
`Note:`

1. The configuration values should be stored in a `variables.tf` file.

2. The Terraform script should be structured with a `main.tf` file referencing `variables.tf`.
The Terraform working directory is `/home/bob/terraform`.

`Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated Terminal to launch the terminal.

## Solution
**What is a Security Group in AWS?**
A `Security Group` in AWS acts as a virtual firewall for your EC2 instances to control inbound and outbound traffic. You can specify rules based on protocols, ports, and source/destination IP ranges. Security Groups are stateful, meaning if you allow incoming traffic on a port, the response is automatically allowed.

```bash

terraform init

terraform plan

terraform apply --auto-approve
```