18. Create Kinesis Stream Using Terraform

>The more that you read, the more things you will know. The more that you learn, the more places you'll go.
>
>– Dr. Seuss

The Nautilus DevOps team needs to create an AWS Kinesis data stream for real-time data processing. This stream will be used to ingest and process large volumes of streaming data, which will then be consumed by various applications for analytics and real-time decision-making.

- The stream should be named `devops-stream`.

- Use Terraform to create this Kinesis stream.

- The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

**Note:**

- Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.
- Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.
- The name of the resource my change, so just want has been specified in the task it might not be `devops-datastream`

## Solution
```bash
cd /home/bob/terraform

terraform init

terraform validate

terraform plan

terraform apply --auto-approve

terraform plan

terraform apply --auto-approve

terraform plan

```
**✅ Breakdown:**
- Configuration `Item`	Value
- Stream Name	`devops-stream`
- Shard Count	`1` (default minimum)
- Retention Period	`24 hours` (default)
- Stream Mode	`PROVISIONED` (standard for fixed shards)
- Region	`us-east-1`

