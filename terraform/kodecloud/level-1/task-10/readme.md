10. Create Snapshot Using Terraform

>Sometimes things aren’t clear right away. 
>That’s where you need to be patient and persevere and see where things lead.
>
>– Mary Pierce


The Nautilus DevOps team has some volumes in different regions in their AWS account. They are going to setup some automated backups so that all important data can be backed up on regular basis. For now they shared some requirements to take a snapshot of one of the volumes they have.

- Create a snapshot of an existing volume named xfusion-vol in `us-east-1` region using terraform.

- 1) The name of the snapshot must be xfusion-vol-ss.

- 2) The description must be Xfusion Snapshot.

- 3) Make sure the snapshot status is completed before submitting the task.

- The Terraform working directory is `/home/bob/terraform`. Update the `main.tf` file (do not create a separate `.tf` file) to accomplish this task.

`Note:` `Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform validate

terraform plan

terraform apply --auto-approve

```


