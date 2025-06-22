17. Create Dynamo DB Table Using Terraform

>All you need is the plan, the road map, and the courage to press on to your destination.
>
>– Earl Nightingale

The Nautilus DevOps team needs to set up a DynamoDB table for storing user data. They need to create a DynamoDB table with the following specifications:

1) The table name should be `datacenter-users`.

2) The primary key should be `datacenter_id (String)`.

3) The table should use `PAY_PER_REQUEST` billing mode.

- Use Terraform to create this `DynamoDB table`. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to create the DynamoDB table.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve

```
**💡 Notes:**
- `hash_key` defines the primary (partition) key.

- `type = "S"` means the key is a string.

- `billing_mode = "PAY_PER_REQUEST"` means no need to define `read/write` capacities.
