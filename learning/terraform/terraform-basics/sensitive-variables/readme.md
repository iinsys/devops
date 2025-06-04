# Terraform Sensitive Variables and Outputs

This example demonstrates how to use sensitive variables and outputs in Terraform to protect secrets.

## What are Sensitive Variables and Outputs?
- Marking a variable or output as `sensitive` tells Terraform to hide its value in logs and CLI output.
- This helps prevent accidental exposure of secrets or sensitive data.

## Why Use Sensitive?
- Protects secrets from being displayed in logs, state files, or CI/CD pipelines.
- Encourages best practices for secret management.

## Key Concepts
- Mark variables and outputs as `sensitive` to prevent them from being displayed in logs or output.

## How to Test

1. Initialize and apply:
   ```zsh
   terraform init
   terraform apply -auto-approve -var="secret_value=mysecret"
   ```

2. Observe output:
   - The sensitive value will not be shown in the output.

3. Show output explicitly:
   ```zsh
   terraform output show_secret
   ```
   - You may need to use `terraform output -json` to see the value (not recommended for secrets).

4. Clean up:
   ```zsh
   terraform destroy -auto-approve
   ```

## Notes
- Never hardcode secrets in your Terraform files.
- Use environment variables or secret managers for sensitive values in production.
- Mark outputs as sensitive if they contain secrets.
