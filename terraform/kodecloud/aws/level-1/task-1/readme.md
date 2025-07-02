1. Create Key Pair Using Terraform
   
The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task, create a `key pair` using Terraform with the following requirements:

- Name of the `key pair` should be `xfusion-kp`.

- Key pair `type` must be `rsa`.

- The private key file should be saved under `/home/bob`.
The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.

`Note:` Right-click under the EXPLORER section in VS Code and select Open in `Integrated Terminal` to launch the terminal.

## Solution
In this directory we have our file `main.tf` create similar file on kodecloud vs and cp the code and past, run the following commands below
```bash
terraform init
terraform plan
terraform apply --auto-approve
## verify
 ls -l /home/bob/xfusion-kp.pem 
-rw------- 1 bob bob 3243 Jun  9 09:38 /home/bob/xfusion-kp.pem
```
- This solution also applies the same if the change the name of the key you are supposed to create you just have to modify based on the task discription.
  
`Note`: The provider has already been configured on kodecloud so you don't need to create one, you can only create if you want to use this solution for the creation of your key pair on your aws account
