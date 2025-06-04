# Terraform Error Handling and Debugging

This example demonstrates how to handle and debug errors in Terraform.

## What is Error Handling and Debugging in Terraform?
- When Terraform encounters a problem, it provides detailed error messages to help you fix the issue.
- The `TF_LOG` environment variable enables verbose logging for troubleshooting complex problems.

## Why is This Important?
- Understanding error messages helps you quickly resolve issues and avoid downtime.
- Debug logging can reveal subtle problems in your configuration or environment.

## How to Test

1. Try to apply with an invalid variable (filename is empty):
   ```zsh
   terraform init
   terraform apply -auto-approve
   # You should see an error about the filename being empty.
   ```

2. Set the variable to a valid value:
   ```zsh
   terraform apply -auto-approve -var="filename=debug.txt"
   ls debug.txt
   ```

3. Enable debug logging:
   ```zsh
   export TF_LOG=DEBUG
   terraform plan
   unset TF_LOG
   ```
   - Review the debug output for troubleshooting.

4. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm debug.txt
   ```

## Notes
- Always read error messages carefully—they often tell you exactly what is wrong.
- Use `TF_LOG` for more details when troubleshooting complex issues.
- Debugging is a normal part of working with infrastructure as code.
