# Terraform Workspaces (Local)

This example demonstrates how to use Terraform workspaces to manage multiple environments with the same code.

## What are Workspaces?
- Workspaces in Terraform let you use the same configuration for different environments (like dev, staging, prod) by keeping separate state files for each.
- Each workspace is isolated, so resources created in one workspace do not affect others.

## Why Use Workspaces?
- They make it easy to test changes in a dev environment before applying to prod.
- You can manage multiple similar deployments with a single codebase.

## Key Concepts
- Workspaces allow you to use the same configuration for different environments (e.g., dev, staging, prod).
- Each workspace has its own state file.

## How to Test

1. Initialize:
   ```bash
   terraform init
   ```

2. Create and switch workspaces:
   ```bash
   terraform workspace new dev
   terraform workspace new prod
   terraform workspace select dev
   terraform apply -auto-approve
   terraform workspace select prod
   terraform apply -auto-approve
   ```

3. Check created files:
   ```bash
   ls workspace-*.txt
   cat workspace-dev.txt
   cat workspace-prod.txt
   ```

4. Clean up:
   ```bash
   terraform workspace select default
   terraform workspace delete dev
   terraform workspace delete prod
   terraform destroy -auto-approve
   rm workspace-*.txt
   ```

## Notes
- Workspaces are great for simple environment separation, but for complex scenarios, consider using separate state backends or directories.
- Each workspace maintains its own state.
