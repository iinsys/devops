# Terraform Importing Existing Resources

This example demonstrates how to import an existing resource into Terraform management.

## What is Importing?
- Importing lets you bring existing infrastructure under Terraform management without recreating it.
- You must write the resource block in your configuration to match the real resource, then use `terraform import` to associate it with your state.

## Why Import?
- Useful for migrating legacy infrastructure to Terraform.
- Lets you manage resources created outside of Terraform.

## Key Concepts
- Use `terraform import` to bring existing infrastructure under Terraform control.
- The resource must exist before importing.

## How to Test

1. Manually create a file:
   ```zsh
   echo "This file was imported into Terraform!" > imported.txt
   ```

2. Initialize Terraform:
   ```zsh
   terraform init
   ```

3. Import the file:
   ```zsh
   terraform import local_file.imported ./imported.txt
   ```

4. Show the state:
   ```zsh
   terraform state list
   terraform show
   ```

5. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm imported.txt
   ```

## Notes
- The resource configuration in `main.tf` must match the actual resource being imported.
- After import, Terraform will manage the resource as if it created it.
- Import does not update your configuration file—only the state.
