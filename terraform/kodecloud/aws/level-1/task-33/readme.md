33. Delete VPC Using Terraform


>I hear and I forget. I see and I remember. I do and I understand.
>
>– Confucius

The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. They created some services in different regions and later found that some of those can be deleted now.

Delete a VPC named `devops-vpc` present in `us-east-1` region using `Terraform`. Make sure to keep the provisioning code, as we might need to provision this instance again later.

The Terraform working directory is `/home/bob/terraform`.

`Note:` `Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

```bash
terraform plan -destroy  # Confirm Terraform plans to destroy the instance

terraform destroy --auto-approve
```