Day 96: Create EC2 Instance Using Terraform

>Don't give up. Normally it is the last key on the ring which opens the door.
>
>– Paulo Coelho

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

For this task, create an EC2 instance using `Terraform` with the following requirements:

1. The name of the instance must be xfusion-ec2.

2. Use the `Amazon Linux ami-0c101f26f147fa7fd` to launch this instance.

3. The Instance type must be `t2.micro`.

4. Create a new `RSA key` named `xfusion-kp`.

5. Attach the `default (available by default) security group`.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different .tf file) to provision the instance.

`Note:` Right-click under the `EXPLORER` section in `VS Code` and select `Open in Integrated Terminal` to launch the terminal.

## Solution
```bash
cd /home/bob/terraform
touch main.tf

terraform init

terraform validate

terraform plan

terraform apply -auto-approve
```