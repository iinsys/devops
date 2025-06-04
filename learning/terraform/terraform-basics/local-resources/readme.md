# Terraform Local Resources and Data Sources

This example demonstrates how to use local resources and data sources in Terraform.

## What are Local Resources?
- The `local_file` resource lets you create files on your local machine as part of your Terraform workflow. This is useful for generating config files, secrets, or any artifacts needed by other tools.
- The `local_sensitive_file` resource is similar, but marks the file's contents as sensitive, so Terraform will avoid showing it in logs or output.

## What are Data Sources?
- Data sources in Terraform allow you to fetch or compute data for use elsewhere in your configuration. The `data.local_file` data source reads the contents of a file so you can use it in outputs or other resources.

## How to Test

1. Initialize and apply:
   ```zsh
   terraform init
   terraform apply -auto-approve
   ls basic.txt secret.txt
   cat basic.txt
   # Do not cat secret.txt in real scenarios!
   ```

2. Read file content with data source:
   ```zsh
   terraform console
   > data.local_file.read_basic.content
   exit
   ```

3. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm basic.txt secret.txt
   ```

## Notes
- Use `local_sensitive_file` for secrets, but prefer secret managers in production.
- Data sources let you use file contents in other resources or outputs.
- Local resources are great for demos and local automation, but not for managing cloud infrastructure.
