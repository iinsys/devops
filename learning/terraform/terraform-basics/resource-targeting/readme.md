# Terraform Resource Targeting and Dependency Management

This example demonstrates how to apply or destroy only specific resources and understand dependencies in Terraform.

## What is Resource Targeting?
- Resource targeting lets you apply or destroy only specific resources using the `-target` flag.
- This is useful for troubleshooting or incremental changes, but should not be your default workflow.

## How Does Dependency Management Work?
- Terraform automatically manages dependencies between resources based on references in your configuration.
- When you target a resource, Terraform will also create any dependencies required for that resource.

## How to Test

1. Initialize and apply only one resource:
   ```zsh
   terraform init
   terraform apply -target=local_file.foo -auto-approve
   ls foo.txt bar.txt  # Only foo.txt should exist
   ```

2. Apply the rest:
   ```zsh
   terraform apply -auto-approve
   ls foo.txt bar.txt  # Now both files should exist
   ```

3. Destroy only one resource:
   ```zsh
   terraform destroy -target=local_file.bar -auto-approve
   ls foo.txt bar.txt  # Only foo.txt should remain
   ```

4. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm foo.txt bar.txt
   ```

## Notes
- Use targeting for troubleshooting or incremental changes, not as a regular workflow.
- Let Terraform manage dependencies automatically for best results.
