# Terraform Testing and Validation

This example demonstrates how to test and validate your Terraform code.

## What is Testing and Validation in Terraform?
- `terraform validate` checks your configuration for syntax errors and internal consistency before you apply changes.
- `terraform fmt` automatically formats your code to the standard style.
- `terraform taint` marks a resource for recreation on the next apply, useful for troubleshooting or forcing updates.

## Why Test and Validate?
- Prevents simple mistakes from reaching your infrastructure.
- Ensures your code is readable and maintainable.
- Lets you safely force recreation of resources if needed.

## Key Concepts
- Use `terraform validate` to check configuration syntax and internal consistency.
- Use `terraform fmt` to format code.
- Use `terraform taint` to force resource recreation.

## How to Test

1. Validate and format:
   ```zsh
   terraform validate
   terraform fmt
   ```

2. Apply and taint:
   ```zsh
   terraform apply -auto-approve
   terraform taint local_file.test
   terraform apply -auto-approve
   ```
   - The file will be recreated.

3. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm test.txt
   ```

## Notes
- Always validate and format your code before applying.
- Use taint for troubleshooting or forcing recreation of resources.
- Testing and validation are key to safe, reliable infrastructure as code.
