# Terraform Provisioners (local-exec & remote-exec)

This example demonstrates how to use provisioners in Terraform to run scripts or commands during resource creation.

## What are Provisioners?
- Provisioners let you execute scripts or commands on the local machine (`local-exec`) or on a remote resource (`remote-exec`) as part of the resource lifecycle.
- They are useful for bootstrapping, configuration, or integration with other tools.

## When to Use Provisioners?
- Use provisioners for tasks that cannot be accomplished with native Terraform resources.
- Avoid using them for critical infrastructure logic—prefer configuration management tools or cloud-init for production.

## How to Test

1. Initialize and apply:
   ```zsh
   terraform init
   terraform apply -auto-approve
   ls local-exec.txt
   # Check /tmp/remote-exec.txt if using remote-exec with a real remote host
   ```

2. Clean up:
   ```zsh
   terraform destroy -auto-approve
   rm local-exec.txt
   # Remove /tmp/remote-exec.txt if created
   ```

## Notes
- Provisioners are best for demos, bootstrapping, or one-off tasks.
- For production, use configuration management tools or cloud-init instead.
