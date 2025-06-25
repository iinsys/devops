20. Create SSM Parameter Using Terraform

>All you need is the plan, the road map, and the courage to press on to your destination.
>
>– Earl Nightingale

The Nautilus DevOps team needs to create an SSM parameter in AWS with the following requirements:

1) The name of the parameter should be `datacenter-ssm-parameter`.

2) Set the parameter type to `String`.

3) Set the parameter value to `datacenter-value`.

4) The parameter should be created in the `us-east-1` region.

5) Ensure the parameter is successfully created using `terraform` and can be retrieved when the task is completed.

The Terraform working directory is `/home/bob/terraform`.` Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve
```