35. VPC Variable Setup Using Terraform

>You don’t understand anything until you learn it more than one way.
>
>– Marvin Minsky

The Nautilus DevOps team is automating VPC creation using Terraform to manage networking efficiently. As part of this task, they need to create a VPC with specific requirements.

For this task, create an `AWS VPC` using `Terraform` with the following requirements:

The VPC name `nautilus-vpc` should be stored in a variable named `KKE_vpc`.

The VPC should have a `CIDR block` of `10.0.0.0/16`.

`Note:`

The configuration values should be stored in a `variables.tf` file.

The Terraform script should be structured with a `main.tf` file referencing variables.tf.

The Terraform working directory is `/home/bob/terraform`.

`Right-click` under the `EXPLORER` section in VS Code and select Open in Integrated Terminal to launch the terminal.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve
```

