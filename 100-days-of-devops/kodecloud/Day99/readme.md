Day 99: Attach IAM Policy for DynamoDB Access Using Terraform

>In learning you will teach, and in teaching you will learn.
>
>– Phil Collins

The DevOps team has been tasked with creating a secure DynamoDB table and enforcing fine-grained access control using IAM. This setup will allow secure and restricted access to the table from trusted AWS services only.

As a member of the Nautilus DevOps Team, your task is to perform the following using Terraform:

1. `Create a DynamoDB Table`: Create a table named `devops-table` with minimal configuration.

2. `Create an IAM Role`: Create an IAM role named `devops-role` that will be allowed to access the table.

3. `Create an IAM Policy`: Create a policy named `devops-readonly-policy` that should grant read-only access (GetItem, Scan, Query) to the specific DynamoDB table and attach it to the role.

4. Create the `main.tf` file (do not create a separate `.tf` file) to provision the table, role, and policy.

5. Create the `variables.tf` file with the following variables:

- `KKE_TABLE_NAME`: name of the DynamoDB table
- `KKE_ROLE_NAME`: name of the IAM role
- `KKE_POLICY_NAME`: name of the IAM policy
6. Create the outputs.tf file with the following outputs:

- `kke_dynamodb_table`: name of the DynamoDB table
- `kke_iam_role_name`: name of the IAM role
- `kke_iam_policy_name`: name of the IAM policy
7. Define the actual values for these variables in the `terraform.tfvars` file.

8. Ensure that the IAM policy allows only read access and restricts it to the specific `DynamoDB table `created.


`Notes:`

1. The Terraform working directory is `/home/bob/terraform`.

2. `Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated Terminal to launch the terminal.

3. Before submitting the task, ensure that terraform plan returns `No changes. Your infrastructure matches the configuration`.

## Solution
```bash
cd /home/bob/terraform

terraform init

terraform validate

terraform plan

terraform apply -auto-approve

# run again
terraform init

terraform plan
```




