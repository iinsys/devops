31. Delete IAM Group Using Terraform


>The best way to guarantee a loss is to quit.
>
>– Morgan Freeman

The Nautilus DevOps team is currently engaged in a cleanup process, focusing on removing unnecessary data and services from their AWS account. As part of the migration process, several resources were created for one-time use only, necessitating a cleanup effort to optimize their AWS environment.

Delete an IAM group named `iamgroup_kirsty` using `terraform`. Make sure to keep the provisioning code, as we might need to provision this instance again later.

The Terraform working directory is `/home/bob/terraform`.

`Note:` `Right-click` under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

```bash
terraform plan -destroy  # Confirm Terraform plans to destroy the instance

terraform destroy --auto-approve
```
