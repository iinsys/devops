7. Create EC2 Instance Using Terraform

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

- For this task, create an EC2 instance using Terraform with the following requirements:

- The name of the instance must be `nautilus-ec2`.

- Use the Amazon Linux `ami-0c101f26f147fa7fd` to launch this instance.

- The Instance type must be `t2.micro`.

- Create a new `RSA key` named `nautilus-kp`.

- Attach the default (available by default) security group.

The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to provision the instance.

`Note:` `Right-click` under the `EXPLORER` section in `VS Code` and select Open in Integrated `Terminal to launch the terminal`.

## Solution
```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```
## Terraform Resources Explanation

### 1. `tls_private_key "nautilus_key"`
- **Purpose**: Generates a new RSA private key.
- **Use Case**: This private key is used to create an EC2 key pair and later stored as a `.pem` file to SSH into the instance.
- **Config Highlights**:
  ```hcl
  algorithm = "RSA"
  rsa_bits  = 4096
  ```

---

### 2. `aws_key_pair "nautilus_kp"`
- **Purpose**: Creates an EC2 key pair in AWS using the public key from `tls_private_key`.
- **Use Case**: Allows you to SSH securely into the EC2 instance.
- **Config Highlights**:
  ```hcl
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_key.public_key_openssh
  ```

---

### 3. `local_file "private_key"`
- **Purpose**: Saves the private key locally on your machine.
- **Use Case**: Provides a `.pem` file (e.g., `nautilus-kp.pem`) to authenticate SSH access to the EC2 instance.
- **Security**: 
  ```hcl
  file_permission = "0400"
  ```

---

### 4. `aws_instance "nautilus_ec2"`
- **Purpose**: Provisions a new Amazon EC2 instance.
- **Use Case**: Launches a server with:
  - **AMI ID**: `ami-0c101f26f147fa7fd` (Amazon Linux)
  - **Instance Type**: `t2.micro` (free tier eligible)
  - **SSH Key**: `nautilus-kp`
  - **Security Group**: default (via lookup)
  - **Name Tag**: `nautilus-ec2` (for easy identification)
