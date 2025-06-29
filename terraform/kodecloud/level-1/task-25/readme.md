25. Change Instance Type Using Terraform

>Don't give up. Normally it is the last key on the ring which opens the door.
>
>– Paulo Coelho

During the migration process, the Nautilus DevOps team created several EC2 instances in different regions. They are currently in the process of identifying the correct resources and utilization and are making continuous changes to ensure optimal resource utilization. Recently, they discovered that one of the EC2 instances was underutilized, prompting them to decide to change the instance type. Please make sure the Status check is completed (if it's still in Initializing state) before making any changes to the instance.

- Change the instance type from `t2.micro` to `t2.nano` for `xfusion-ec2` instance using terraform.

- Make sure the EC2 instance `xfusion-ec2` is in running state after the change.

The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to change the instance type.

`Note:` `Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.


## Solution
```bash
## To get the install id use: aws cli is already installed but you can check the version 
aws --version

## Extract instance id
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=xfusion-ec2" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

## you should see something like this 
i-613f88c2deec99951

## check instance status
aws ec2 describe-instance-status --instance-ids i-613f88c2deec99951 \
  --query "InstanceStatuses[*].InstanceStatus.Status" --output text

## you should see 
ok

## apply new changes you have done to update the instance type from micro to nano
terraform apply --auto-approve


## verify instance type to make sure changes were correct 
aws ec2 describe-instances --instance-ids i-613f88c2deec99951 \
  --query "Reservations[*].Instances[*].InstanceType" --output text

## you should see
t2.nano

```

## Note: 
you instance id might change so don't use exactly this one in the steps you can extract your instance id using the first command 