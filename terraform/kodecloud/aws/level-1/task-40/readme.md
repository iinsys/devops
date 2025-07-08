40. Policy Variable Setup Using Terraform

>There are times to stay put, and what you want will come to you, and there are times to go out into the world and find such a thing for yourself.
>
>– Lemony Snicket

The Nautilus DevOps team is automating IAM policy creation using Terraform to enhance security and access management. As part of this task, they need to create an IAM policy with specific requirements.

For this task, create an `AWS IAM policy` using Terraform with the following requirements:

The `IAM policy` name `iampolicy_rose` should be stored in a variable named `KKE_iampolicy`.
`Note:`

The configuration values should be stored in a `variables.tf` file.

- The Terraform script should be structured with a `main.tf` file referencing `variables.tf`.

- The Terraform working directory is `/home/bob/terraform`.

`Right-click` under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution

**What is a policy in AWS?**

An AWS IAM policy is a JSON document that defines permissions for actions on AWS resources. Policies are attached to users, groups, or roles to grant or restrict access. They are a core part of AWS security and access management, allowing fine-grained control over who can do what in your AWS environment.

**References:**
- [AWS IAM Policies Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [Terraform aws_iam_policy Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)

```bash
terraform init

terraform plan

terraform apply --auto-approve
```