30. Delete EC2 Instance Using Terraform

>Arise, awake, and stop not till the goal is reached.
>
>– Swami Vivekananda

>You don’t learn to walk by following rules. You learn by doing, and falling over.
>
>– Richard Branson

During the migration process, several resources were created under the AWS account. Some of these test resources are no longer needed at the moment, so we need to clean them up temporarily. One such instance is currently unused and should be deleted.

1) Delete the ec2 instance named `devops-ec2` present in `us-east-1` region using terraform. 
- Make sure to keep the provisioning code, as we might need to provision this instance again later.

2) Before submitting your task, make sure instance is in terminated state.

- The Terraform working directory is `/home/bob/terraform`.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
Use the commands below to destroy the resource
```bash
terraform plan -destroy  # Confirm Terraform plans to destroy the instance

terraform destroy --auto-approve

## to confirm use this 
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=devops-ec2" \
  --query "Reservations[*].Instances[*].State.Name" \
  --output text
## and you should see 
terminated
```