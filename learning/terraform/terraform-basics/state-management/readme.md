# Terraform State Management (Local)

This example demonstrates how Terraform manages state locally.

## What is Terraform State?
- Terraform state is how Terraform keeps track of the resources it manages. The state file (`terraform.tfstate`) maps your configuration to real infrastructure objects.
- The `local` backend stores state in a file in your project directory. This is great for learning and solo projects, but for teams, use a remote backend.

## Why is State Important?
- State enables Terraform to know what it created, detect drift, and plan changes.
- Never edit the state file manually—always use Terraform commands.

## Key Concepts
- The `local` backend stores state in a file (`terraform.tfstate`) in your project directory.
- State tracks resources Terraform manages.

## How to Test

1. Initialize and apply:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

2. Inspect state:
   ```bash
   terraform show
   terraform state list
   ```

3. Move or remove state:
   ```bash
   terraform state mv local_file.example local_file.renamed
   terraform state rm local_file.renamed
   ```

4. Clean up:
   ```bash
   terraform destroy -auto-approve
   rm terraform.tfstate*
   rm hello.txt
   ```

## Notes
- State is critical for tracking your infrastructure.
- For collaboration, use a remote backend (like S3, Azure Blob, etc.).
